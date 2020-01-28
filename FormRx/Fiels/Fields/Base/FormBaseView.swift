//
//  FormBaseView.swift
//  Form
//
//  Created by Artem on 7/29/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit


open class FormBaseView: UIView, FormBaseStateProtocol {

    // MARK: -
    // MARK: ** UI Components **
    
    open lazy var wrapperStackView: UIStackView = {
        return makeStackView()
    }()
    
    open var titleView: FormTitleView!
    
    open lazy var contentWrapperStackView: UIStackView = {
        return makeStackView()
    }()

    public var errorView: FormErrorView!

    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }
    
    // MARK: -
    // MARK: ** ViewModels **
    
    var baseViewModel: FormBaseViewModel! {
        didSet { setupBaseViewModel() }
    }
    
    open var titleViewModel: FormTitleViewModel! {
        didSet { setupTitleViewModel() }
    }
    
    open var errorViewModel: FormErrorViewModel! {
        didSet { setupErrorViewModel() }
    }
    
    override open var isHidden: Bool {
        get { return super.isHidden }
        set {
            super.isHidden = newValue
            baseViewModel?.rxIsEnabled.accept(newValue)
        }
    }
    
    var disposeBag = DisposeBag()
    
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
    
    func makeUI() {
        
        wrapperStackView.addArrangedSubview(contentWrapperStackView)
        pinSubview(wrapperStackView)
    }
    
    private func setupBaseViewModel() {
        
        disposeBag = DisposeBag()
        
        guard let baseViewModel = baseViewModel else { return }
        
        disposeBag.insert(
            baseViewModel.rxIsEnabled.observeOn(MainScheduler.asyncInstance).bind(to: rx.isEnabled),
            baseViewModel.rxValidationResult.observeOn(MainScheduler.asyncInstance).bind(to: rx.validationResult)
        )
    }
    
    private func setupTitleViewModel() {
        
        guard let titleViewModel = titleViewModel else { return }
        
        guard let titleView = titleView else {
            
            let titleView = FormTitleView(viewModel: titleViewModel)
            wrapperStackView.insertArrangedSubview(titleView, at: 0)
            
            self.titleView = titleView
            return
        }
        
        titleView.viewModel = titleViewModel
    }
    
    private func setupErrorViewModel() {
        
        guard let errorViewModel = errorViewModel else {
            
            errorView?.removeFromSuperview()
            errorView = nil
            
            return
        }
        
        guard let errorView = errorView else {
            
            let errorView = FormErrorView(viewModel: errorViewModel)
            
            styleErrorView?(errorView)
            wrapperStackView.addArrangedSubview(errorView)
            
            self.errorView = errorView
            
            return
        }
        
        errorView.viewModel = errorViewModel
    }
    
    public var styleErrorView: ((FormErrorView) -> ())?
}

// MARK: -
// MARK: ** StateProtocol **

extension FormBaseView {

    @objc func setEnabled(_ isEnabled: Bool) {
        print("setEnabled", isEnabled)

        isUserInteractionEnabled = isEnabled
    }

    @objc func setOk() {
        print("setOk")
        
        // Reset auto
        if baseViewModel.settings.resetAutoWhenOk {
            baseViewModel.rxIsAuto.accept(false)
        }
        
        errorViewModel = nil
    }
    
    @objc func setError(_ errorText: String) {
        
        errorViewModel = FormErrorViewModel(text: errorText)
    }
}
