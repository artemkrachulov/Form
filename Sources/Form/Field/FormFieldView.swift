//
//  FormFieldView.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormFieldView: UIView {

    // MARK: -
    // MARK: ** UI Components **
    
    public var wrapperStackView: UIStackView!
    public var titleView: FormTitleView!
    public var contentWrapperStackView: UIStackView!
    public var errorView: FormErrorView!

    // MARK: -
    // MARK: ** Properties **
    
    // ViewModels
    
    public var baseViewModel: FormFieldViewModel! {
        didSet { setBaseViewModel() }
    }
    
    public var titleViewModel: FormTitleViewModel! {
        didSet { setTitleViewModel() }
    }
    
    public var errorViewModel: FormErrorViewModel! {
        didSet { setErrorViewModel() }
    }
    
    // Variables
    
    override open var isHidden: Bool {
        get { return super.isHidden }
        set {
            super.isHidden = newValue
            baseViewModel?.isEnabled = isHidden
        }
    }
    
    // MARK: -
    // MARK: ** Initialization **
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.makeUI()
    }
    
    // MARK: -
    // MARK: ** Setup methods **
    
    func makeUI() {
        
        wrapperStackView = FormFieldView.makeStackView(axis: .vertical)
        contentWrapperStackView = FormFieldView.makeStackView(axis: .vertical)
        
        wrapperStackView.addArrangedSubview(contentWrapperStackView)
        pinSubview(wrapperStackView)
    }
    
    private func setBaseViewModel() {

        baseViewModel.setEnabled = setEnabled
        baseViewModel.setValidationResult = setValidationResult
        baseViewModel.setClear = setOk
    }
    
    private func setTitleViewModel() {
        
        guard let titleViewModel = titleViewModel else {
            titleView?.removeFromSuperview()
            titleView = nil
            return
        }
        
        guard let titleView = titleView else {
            
            let titleView = FormTitleView(viewModel: titleViewModel)
            wrapperStackView.insertArrangedSubview(titleView, at: 0)
            self.titleView = titleView
            //
            decorateTitleView?(titleView)
            //
            return
        }
        
        titleView.viewModel = titleViewModel
    }
    
    private func setErrorViewModel() {
        
        guard let errorViewModel = errorViewModel else {
            errorView?.removeFromSuperview()
            errorView = nil
            return
        }
        
        guard let errorView = errorView else {
            
            let errorView = FormErrorView(viewModel: errorViewModel)
            wrapperStackView.addArrangedSubview(errorView)
            self.errorView = errorView
            //
            decorateErrorView?(errorView)
            //
            return
        }
        
        errorView.viewModel = errorViewModel
    }
    
    static func makeStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    
    // MARK: -
    // MARK: ** Style methods **
    
    public var decorateTitleView: ((FormTitleView) -> ())? {
        didSet {
            guard let titleView = titleView else { return }
            decorateTitleView?(titleView)
        }
    }
    
    public var decorateErrorView: ((FormErrorView) -> ())? {
        didSet {
            guard let errorView = errorView else { return }
            decorateErrorView?(errorView)
        }
    }
}

// MARK: -
// MARK: ** FormFieldStateProtocol **

extension FormFieldView: FormFieldStateProtocol {

    @objc func setEnabled(_ isEnabled: Bool) {
        print("setEnabled", isEnabled)
        isUserInteractionEnabled = isEnabled
    }
    
    func setValidationResult(_ validationResult: FormValidationResult) {
        print("setValidationResult", validationResult)
        baseViewModel.splitValidationResult(ok: setOk, error: setError)
    }
    
    @objc func setOk() {
        errorViewModel = nil
    }

    @objc func setError(_ errorText: String) {
        errorViewModel = FormErrorViewModel(text: errorText)
    }
}
