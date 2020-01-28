//
//  FormInputView.swift
//  Form
//
//  Created by Artem on 7/25/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

public class FormFieldView: FormInputView, FormInputStateProtocol {
    
    // MARK: -
    // MARK: ** UI Components **
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        return textField
    }()
    
    public lazy var placeholderLabel: FormFieldPlaceholderLabel = {
        let label = FormFieldPlaceholderLabel()
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    public var height: CGFloat? {
        didSet {
            
            if let height = height {

                if heightConstraint == nil {
                    heightConstraint = textField.heightAnchor.constraint(equalToConstant: 50)
                }
                
                heightConstraint?.isActive = true
                heightConstraint?.constant = height
            } else {
                heightConstraint?.isActive = false
            }
        }
    }
    
    public weak var delegate: FormFieldViewDelegate?
    
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
        
        makeViews(inputView: textField, placeholderView: placeholderLabel)
        height = 50
    }
    
    override func setupViewModel() {
        super.setupViewModel()
     
        placeholderLabel.text = viewModel.placeholderLabelText
        
        disposeBag.insert(
            // Bind text
            textField.rx.text <-> viewModel.rxValue,
            // Bind highlight event
            Observable.merge(
                textField.rx.controlEvent(.editingDidBegin).map({ true }),
                textField.rx.controlEvent(.editingDidEnd).map({ false })
            ).startWith(false).bind(to: viewModel.rxIsHighlighted),
            //
            viewModel.rxIsHighlighted.bind(to: rx.isHighlighted),
            // Reset
            textField.rx.text.subscribe(onNext: { [weak viewModel] value in
                
                guard let viewModel = viewModel else { return }
                
                if (value ?? "").isEmpty && viewModel.validationService.settings.resetOnEmpty {
                    viewModel.baseViewModel.rxManualValidationResult.accept(.ok)
                }
            })
        )
    }
    
    public func setFieldPadding(_ padding: CGFloat, side: Side) {
        
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.size.height))
        spaceView.backgroundColor = .clear
        
        switch side {
        case .left:
            // Base insets
            placeholderLabel.leftInset = padding
            //
            textField.leftViewMode = .always
            textField.leftView = spaceView
            
        case .right:
            placeholderLabel.rightInset = padding
            //
            textField.rightViewMode = .always
            textField.rightView = spaceView
        }
        
        layoutIfNeeded()
    }
    
    override func setView(_ view: UIView?, for side: Side) {
        
        switch side {
        case .left:
            fieldLeftView = view
        case .right:
            fieldRightView = view
        }
        
        guard let view = view else {
            setFieldPadding(side == .left ? placeholderLabel.leftInset : placeholderLabel.rightInset, side: side)
            return
        }
        
        switch side {
        case .left:
            view.frame.size = CGSize(width: placeholderLabel.leftInset + view.frame.width + placeholderLabel.leftInset, height: textField.frame.size.height)
            //
            textField.leftViewMode = .always
            textField.leftView = view
            //
            placeholderLabel.leftInset = view.frame.width
        case .right:
            view.frame.size = CGSize(width: placeholderLabel.rightInset + view.frame.width + placeholderLabel.rightInset, height: textField.frame.size.height)
            //
            textField.rightViewMode = .always
            textField.rightView = view
            //
            placeholderLabel.rightInset = view.frame.width
        }
        
        layoutIfNeeded()
    }

    // MARK: -
    // MARK: ** Closures **
    
    public var highlighted: ((FormFieldView, Bool) -> Void)?
    public var enabled: ((FormFieldView, Bool) -> Void)?
    public var error: ((FormFieldView) -> Void)?
}

// MARK: -
// MARK: ** FormInputStateProtocol **

extension FormFieldView {
    
    func setHighlighted(_ isHighlighted: Bool) {
        print("setHighlighted", isHighlighted)

        // Closure
        highlighted?(self, isHighlighted)
    }
    
    override func setEnabled(_ isEnabled: Bool) {

        // Closure
        enabled?(self, isEnabled)
    }
    
    override func setOk() {
        super.setOk()
        
        // Closure
        highlighted?(self, viewModel.isHighlighted)
        
        delegate?.formFieldViewDidSetOk(self)
    }

    override func setError(_ errorText: String) {
        print("setError", errorText)
        
        // Closure
        error?(self)
        
        // Style error view if allowed
        guard delegate?.formFieldViewShouldShowAnError(self, errorString: errorText) ?? true else { return }
        super.setError(errorText)
    }
}

public protocol FormFieldViewDelegate: class {
    
    func formFieldViewDidSetOk(_ fieldView: FormFieldView)
    func formFieldViewShouldShowAnError(_ fieldView: FormFieldView, errorString: String) -> Bool
}
