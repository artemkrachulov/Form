//
//  FormTextView.swift
//  Form
//
//  Created by Artem on 09.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormTextView: FormInputView, FormInputStateProtocol {
    
    // MARK: -
    // MARK: ** UI Components **
    
    @objc public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = true
        return textView
    }()
    
    public lazy var placeholderTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    // MARK: -
    // MARK: ** Properties **
    
    public weak var delegate: FormTextViewDelegate?
    private var textObservation: NSKeyValueObservation?
    
    // MARK: -
    // MARK: ** Initialization **
    
    public init(viewModel: FormInputViewModel) {
        defer { self.viewModel = viewModel }
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func makeUI() {
        super.makeUI()
        
        formInputView = textView
        inputViewHeight = 150
        
        let placeholderFieldViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(placeholderFieldViewTapGesture(_:)))
        placeholderTextView.addGestureRecognizer(placeholderFieldViewTapGesture)
        
        let contentView = UIView()
        contentView.pinSubview(textView)
        contentView.pinSubview(placeholderTextView)
        
        contentWrapperStackView.addArrangedSubview(contentView)
    }
    
    override func setViewModel() {
        super.setViewModel()
        
        textView.text = viewModel.value
        placeholderTextView.text = viewModel.placeholderLabelText
        
        textView.delegate = self
        
        textObservation = observe(\.textView.text, options: [.new]) { [weak self] object, change in
            guard let strongSelf = self else { return }
            strongSelf.textViewDidChange(strongSelf.textView)
        }
        
        viewModel.setHighlighted = setHighlighted
        
        viewModel.setPlaceholderLabelHidden = { [weak placeholderTextView] isHidden in
            placeholderTextView?.isHidden = isHidden
        }
    }
    
    public func setFieldPadding(_ insets: UIEdgeInsets) {
        textView.textContainerInset = insets
        placeholderTextView.textContainerInset = insets
    }
    
    @objc private func placeholderFieldViewTapGesture(_ gesture: UITapGestureRecognizer) {
        textView.becomeFirstResponder()
    }
    
    // MARK: -
    // MARK: ** Closures **
    
    public var decorateError: ((FormTextView) -> Void)? {
        didSet { decorateError?(self) }
    }
    
    public var decorateEnabled: ((FormTextView, Bool) -> Void)? {
        didSet {
            guard let viewModel = viewModel else { return }
            decorateEnabled?(self, viewModel.baseViewModel.isEnabled)
        }
    }
    
    public var decorateHighlighted: ((FormTextView, Bool) -> Void)? {
        didSet {
            guard let viewModel = viewModel else { return }
            decorateHighlighted?(self, viewModel.isHighlighted)
        }
    }
}

// MARK: -
// MARK: ** FormInputStateProtocol **

extension FormTextView {
    
    func setHighlighted(_ isHighlighted: Bool) {
        // Decorate
        decorateHighlighted?(self, isHighlighted)
    }
    
    override func setEnabled(_ isEnabled: Bool) {
        super.setEnabled(isEnabled)
        // Decorate
        decorateEnabled?(self, isEnabled)
    }
    
    override func setOk() {
        super.setOk()
        // Decorate
        decorateHighlighted?(self, viewModel.isHighlighted)
        // Delegate
        delegate?.formTextViewDidSetOk?(self)
    }
    
    override func setError(_ errorText: String) {
        
        // Decorate
        decorateError?(self)
        
        // Style error view if allowed
        guard delegate?.formTextViewShouldShowAnError?(self, errorString: errorText) ?? true else { return }
        super.setError(errorText)
    }
}

extension FormTextView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        viewModel.value = textView.text
        delegate?.formTextViewDidChange?(self)
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return delegate?.formTextViewShouldBeginEditing?(self) ?? true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return delegate?.formTextViewShouldEndEditing?(self) ?? true
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        viewModel.isHighlighted = true
        delegate?.formTextViewDidBeginEditing?(self)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.isHighlighted = false
        delegate?.formTextViewDidEndEditing?(self)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return delegate?.formTextView?(self, shouldChangeTextIn: range, replacementText: text) ?? true
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        delegate?.formTextViewDidChangeSelection?(self)
    }
    
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return delegate?.formTextView?(self, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true
    }
    
//    @available(iOS 10.0, *)
//    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        return delegate?.formTextView?(self, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true
//    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return delegate?.formTextView?(self, shouldInteractWith: URL, in: characterRange) ?? true
    }
    
//    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
////        return delegate?.formTextView?(self, shouldInteractWith: textAttachment, in: characterRange) ?? true
//        return true
//    }
}

@objc public protocol FormTextViewDelegate: class {
    
    @objc optional func formTextViewShouldBeginEditing(_ fieldView: FormFieldView) -> Bool
    @objc optional func formTextViewShouldEndEditing(_ fieldView: FormFieldView) -> Bool
    @objc optional func formTextViewDidBeginEditing(_ fieldView: FormFieldView)
    @objc optional func formTextViewDidEndEditing(_ fieldView: FormFieldView)
    @objc optional func formTextView(_ fieldView: FormFieldView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    @objc optional func formTextViewDidChange(_ fieldView: FormFieldView)
    @objc optional func formTextViewDidChangeSelection(_ fieldView: FormFieldView)
    
    @available(iOS 10.0, *)
    @objc optional func formTextView(_ fieldView: FormFieldView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    
//    @available(iOS 10.0, *)
//    @objc optional func formTextView(_ fieldView: FormFieldView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    
    @objc optional func formTextView(_ fieldView: FormFieldView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool
//    @objc optional func formTextView(_ fieldView: FormFieldView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool
    
    @objc optional func formTextViewDidSetOk(_ fieldView: FormFieldView)
    @objc optional func formTextViewShouldShowAnError(_ fieldView: FormFieldView, errorString: String) -> Bool
}
