//
//  FormTextFieldView.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormTextFieldView: FormInputView, FormInputStateProtocol {
    
    // MARK: -
    // MARK: ** UI Components **
    
    @objc public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        return textField
    }()
    
    // MARK: -
    // MARK: ** Properties **

    public weak var delegate: FormTextFieldViewDelegate?
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
        
        formInputView = textField
        inputViewHeight = 50
        contentWrapperStackView.addArrangedSubview(textField)
    }
    
    override func setViewModel() {
        super.setViewModel()
     
        textField.text = viewModel.value
        textField.placeholder = viewModel.placeholderLabelText
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        textObservation = observe(\.textField.text, options: [.new]) { [weak self] object, change in
            guard let strongSelf = self else { return }
            strongSelf.textFieldDidChange(strongSelf.textField)
        }
        
        viewModel.setHighlighted = setHighlighted
    }

    // MARK: -
    // MARK: ** Closures **
    
    public var decorateError: ((FormTextFieldView) -> Void)? {
        didSet { decorateError?(self) }
    }
    
    public var decorateEnabled: ((FormTextFieldView, Bool) -> Void)? {
        didSet {
            guard let viewModel = viewModel else { return }
            decorateEnabled?(self, viewModel.baseViewModel.isEnabled)
        }
    }
    
    public var decorateHighlighted: ((FormTextFieldView, Bool) -> Void)? {
        didSet {
            guard let viewModel = viewModel else { return }
            decorateHighlighted?(self, viewModel.isHighlighted)
        }
    }
}

// MARK: -
// MARK: ** FormInputStateProtocol **

extension FormTextFieldView {

    func setHighlighted(_ isHighlighted: Bool) {
        // Decorate
        decorateHighlighted?(self, isHighlighted)
    }
    
    override func setEnabled(_ isEnabled: Bool) {
        super.setEnabled(isEnabled)
        // Decorate
        decorateEnabled?(self, isEnabled)
        //
        viewModel?.setEnabled(isEnabled)
    }
    
    override func setOk() {
        super.setOk()
        // Decorate
        decorateHighlighted?(self, viewModel.isHighlighted)
        // Delegate
        delegate?.formTextFieldViewDidSetOk?(self)
    }

    override func setError(_ errorText: String) {

        // Decorate
        decorateError?(self)
        
        // Style error view if allowed
        guard delegate?.formTextFieldViewShouldShowAnError?(self, errorString: errorText) ?? true else { return }
        super.setError(errorText)
    }
}

extension FormTextFieldView: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.value = textField.text
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.formTextFieldViewShouldBeginEditing?(self) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel.isHighlighted = true
        delegate?.formTextFieldViewDidBeginEditing?(self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return delegate?.formTextFieldViewShouldEndEditing?(self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.isHighlighted = false
        delegate?.formTextFieldViewDidEndEditing?(self)
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        viewModel.isHighlighted = false
        delegate?.formTextFieldViewDidEndEditing?(self, reason: reason)
    }
  
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.formTextFieldView?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.formTextFieldViewDidChangeSelection?(self)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.formTextFieldViewShouldClear?(self) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.formTextFieldViewShouldReturn?(self) ?? true
    }
}

@objc public protocol FormTextFieldViewDelegate: class {

    @objc optional func formTextFieldViewShouldBeginEditing(_ fieldView: FormTextFieldView) -> Bool
    @objc optional func formTextFieldViewDidBeginEditing(_ fieldView: FormTextFieldView)
    @objc optional func formTextFieldViewShouldEndEditing(_ fieldView: FormTextFieldView) -> Bool
    @objc optional func formTextFieldViewDidEndEditing(_ fieldView: FormTextFieldView)
    @available(iOS 10.0, *)
    @objc optional func formTextFieldViewDidEndEditing(_ fieldView: FormTextFieldView, reason: UITextField.DidEndEditingReason)
    @objc optional func formTextFieldView(_ fieldView: FormTextFieldView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    @objc optional func formTextFieldViewDidChangeSelection(_ fieldView: FormTextFieldView)
    @objc optional func formTextFieldViewShouldClear(_ fieldView: FormTextFieldView) -> Bool
    @objc optional func formTextFieldViewShouldReturn(_ fieldView: FormTextFieldView) -> Bool
    
    @objc optional func formTextFieldViewDidSetOk(_ fieldView: FormTextFieldView)
    @objc optional func formTextFieldViewShouldShowAnError(_ fieldView: FormTextFieldView, errorString: String) -> Bool
}

