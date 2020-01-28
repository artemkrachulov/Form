//
//  FieldStatesView.swift
//  FormDemo
//
//  Created by Artem on 10/31/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit
import Reusable
//import RxCocoa
//import RxSwift
import Form

class FieldStatesView: UIView, NibOwnerLoadable {

    var viewModel: FieldStatesViewModel! {
        didSet {
            
//            viewModel.rxIsEnabled.drive(onNext: { [unowned self] value in
//                self.enabledIndicatorView.backgroundColor = value ? UIColor.green : UIColor.black.withAlphaComponent(0.2)
//                self.enabledLabel.textColor = UIColor.black
//            }).disposed(by: disposeBag)
//
//            self.optionalIndicatorView.backgroundColor = viewModel.isOptional ? UIColor.black.withAlphaComponent(0.2) : UIColor.red
//            self.optionalLabel.textColor = UIColor.black
//
//            if let rxIsHighlited = viewModel.rxIsHighlited {
//                rxIsHighlited.drive(onNext: { [unowned self] value in
//                    self.highlightedIndicatorView.backgroundColor = value ? UIColor.orange : UIColor.black.withAlphaComponent(0.2)
//                    self.highlightedLabel.textColor = UIColor.black
//                }).disposed(by: disposeBag)
//            } else {
//                self.highlitedStackView.isHidden = true
//            }
//
//            viewModel.rxIsChanged.drive(onNext: { [unowned self] value in
//                self.changedIndicatorView.backgroundColor = value ? UIColor.orange : UIColor.black.withAlphaComponent(0.2)
//                self.changedLabel.textColor = UIColor.black
//            }).disposed(by: disposeBag)
//
//            viewModel.rxIsValid.drive(onNext: { [unowned self] isValid in
//                self.errorIndicatorView.backgroundColor = isValid ? UIColor.green : UIColor.red
//                self.errorLabel.textColor = UIColor.black
//            }).disposed(by: disposeBag)
//
//
//            enabledLabel.rx.text
//                .subscribe(onNext: { [unowned self] value in
//
//                }).disposed(by: disposeBag)
        }
    }
    
    
    
    @IBOutlet weak var wrapperStackView: UIStackView!
    @IBOutlet weak var enabledIndicatorView: UIView!
    @IBOutlet weak var enabledLabel: UILabel!
    @IBOutlet weak var optionalIndicatorView: UIView!
    @IBOutlet weak var optionalLabel: UILabel!
    @IBOutlet weak var highlightedIndicatorView: UIView!
    @IBOutlet weak var highlitedStackView: UIStackView!
    @IBOutlet weak var highlightedLabel: UILabel!
    @IBOutlet weak var changedIndicatorView: UIView!
    @IBOutlet weak var changedLabel: UILabel!
    @IBOutlet weak var errorIndicatorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    var formInputView: FormTextFieldView! {
        didSet {
            
            wrapperStackView.insertArrangedSubview(formInputView, at: 0)
            viewModel = FieldStatesViewModel(inputViewModel: formInputView.viewModel)
            
            
//            formInputView.highlighted = { [weak self] (_, isHighlighted) in
//                self?.highlighted(isHighlighted)
//            }
//            
//            formInputView.enabled = { [weak self] (_, isEnabled) in
//                self?.enabled(isEnabled)
//            }
            
            
            
//            formInputView.changed = { [weak self] (_, isChanged, valudationResult) in
//                self?.changed(isChanged)
//                self?.valid(valudationResult.isValid)
//            }
        }
    }
    
    var formTextView: FormTextView! {
        didSet {
            
            wrapperStackView.insertArrangedSubview(formTextView, at: 0)
            viewModel = FieldStatesViewModel(inputViewModel: formTextView.viewModel)
            

        }
    }
    
    var formCheckboxView: FormCheckboxView! {
        didSet {
            
            wrapperStackView.insertArrangedSubview(formCheckboxView, at: 0)
//            viewModel = FieldStatesViewModel(inputViewModel: formTextView.viewModel)
            
        }
    }
    
    
    
    
//
//    var formGroupView: GroupFormView! {
//        didSet {
//
//            wrapperStackView.insertArrangedSubview(formGroupView, at: 0)
//            viewModel = FieldStatesViewModel(groupViewModel: formGroupView.viewModel)
//        }
//    }
    
    private func highlighted(_ highlighted: Bool) {
        highlightedIndicatorView.backgroundColor = highlighted ? UIColor.orange : UIColor.black.withAlphaComponent(0.2)
//        highlightedLabel.textColor = UIColor.black
    }
    
    private func enabled(_ enabled: Bool) {
        enabledIndicatorView.backgroundColor = enabled ? UIColor.green : UIColor.black.withAlphaComponent(0.2)
//        enabledLabel.textColor = UIColor.black
    }
    
    private func valid(_ valid: Bool) {
        errorIndicatorView.backgroundColor = valid ? UIColor.green : UIColor.red
//        errorLabel.textColor = UIColor.black
    }
    
    private func changed(_ changed: Bool) {
        changedIndicatorView.backgroundColor = changed ? UIColor.orange : UIColor.black.withAlphaComponent(0.2)
//        changedLabel.textColor = UIColor.black
    }
    
    private func optional(_ optional: Bool) {
        optionalIndicatorView.backgroundColor = optional ? UIColor.black.withAlphaComponent(0.2) : UIColor.red
//        optionalLabel.textColor = UIColor.black
    }

    // MARK: -
    // MARK: ** Initialization **
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        loadNibContent()
        
        [enabledIndicatorView, optionalIndicatorView, highlightedIndicatorView, changedIndicatorView, errorIndicatorView].forEach { view in
            view?.layer.cornerRadius = 5
        }
    }
}
