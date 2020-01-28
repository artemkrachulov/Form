//
//  FieldTestViewController.swift
//  FormDemo
//
//  Created by Artem on 10/31/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit
import Form
//import RxSwift
//import RxCocoa

final class FieldTestViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBAction func nextButtonAction(_ sender: Any) {
//        field.viewModel.validate()
    }
    
    @IBAction func valueAction(_ sender: Any) {
//        field.viewModel.setNewValue(nil)
    }
    
    var field: FormFieldView!
    
//    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        makeCheckbox()
//        makeNormalIntField()

//        makeNormalField(in: normalFieldStatesView)
//        makeNormalIntField(in: normalIntFieldStatesView)
//        makeRequiredField(in: requiredFieldStatesView)
//        makeGroupFieldsView(in: groupFieldStatesView)
    }
    
//    func makeCheckbox() {
//
//        let validationService = FormCheckboxValidationService(settings: FormBaseSettings(resetAutoWhenOk: true, validateWhenError: true), requiredClosure: CheckboxValidation.validateEmpty)
//
//        let checkboxViewModel = FormCheckboxViewModel(isOn: false, labelText: "Checkbox label", validationService: validationService)
//        let checkboxView = FormCheckboxView(viewModel: checkboxViewModel)
//
//        checkboxView.iconContainerView.backgroundColor = UIColor.lightGray
//        checkboxView.iconImageView.backgroundColor = UIColor.blue
//
//        checkboxView.checked = { (checkboxView, isChecked) in
//            UIView.animate(withDuration: 0.3) {
//                checkboxView.iconImageView.alpha = isChecked ? 1.0 : 0.0
//            }
//        }
//
//
//        let fieldStatesView = FieldStatesView()
//        fieldStatesView.formCheckboxView = checkboxView
//
//        stackView.addArrangedSubview(fieldStatesView)
//    }
    
//    func makeNormalField(in fieldStatesView: FieldStatesView) {
//
//        let viewModel = FormInputViewModel(text: nil, placeholder: "Placeholder 1...")
//        let view = FormFieldView(viewModel: viewModel)
//
//        fieldStatesView.formInputView = view
//
//    }
    
    func makeNormalIntField() {
//        
//        let validationService = FormInputValidationService(
//            settings: FormInputSettings.allEnabled,
//            requiredClosure: FieldsValidation.validateEmpty,
//            changedClosure: FieldsValidation.validateNumbers)
//        
//        let viewModel = FormInputViewModel(text: nil, placeholder: "Placeholder 1...", validationService: validationService)
//        let view = FormFieldView(viewModel: viewModel)
//        
//        self.field = view
 
//        let fieldStatesView = FieldStatesView(formInputView: view)
//        
//        stackView.addArrangedSubview(fieldStatesView)
        
        //
        
        // Varian 1
//        view.viewModel.baseViewModel.rxIsValid.bind(to: nextButton.rx.isEnabled).disposed(by: disposeBag)
        
        // Variant 2
//        view.viewModel.rxIsChanged.drive(nextButton.rx.isEnabled).disposed(by: disposeBag)
        
        //
        
        
//        nextButton.isEnabled
    }
    
    func makeBindedFields() {
        
//        let validationService = FormInputValidationService(
//            settings: .allEnabled,
//            changedClosure: FieldsValidation.validateMinimum)
//        
//        let viewModel1 = FormInputViewModel(text: nil, placeholder: "Field 3", validationService: validationService)
//        let view1 = FormFieldView(viewModel: viewModel1)
//        
//        let viewModel2 = FormInputViewModel(text: nil, placeholder: "Reapeated Field 3", validationService: .disabled)
//    
//        let validationResult = Observable.combineLatest(viewModel1.rxValue.share(), viewModel2.rxValue.share()).map(FieldsValidation.validateRepeatedPassword)
////        viewModel2.setValidationResult(validationResult: validationResult)
//        
//        let view2 = FormFieldView(viewModel: viewModel2)

        
//        let fieldStatesView1 = FieldStatesView(formInputView: view1)
//        let fieldStatesView2 = FieldStatesView(formInputView: view2)
//        
//        stackView.addArrangedSubview(fieldStatesView1)
//        stackView.addArrangedSubview(fieldStatesView2)
    }
    
    
//    func makeRequiredField(in fieldStatesView: FieldStatesView) {
//
//        let validationService = FormInputValidationService(
//            settings: .allEnabled,
//            requiredClosure: FieldsValidation.validateEmpty, changedClosure: FieldsValidation.validateMinimum)
//
//         let viewModel = FormInputViewModel(text: nil, placeholder: "Placeholder 2...", validationService: validationService)
//         let view = FormFieldView(viewModel: viewModel)
//
//         fieldStatesView.formInputView = view
//    }
    
    /*
    func makeGroupFieldsView(in fieldStatesView: FieldStatesView) {
        
        let inputViewModels = (1...4)
            .map { int -> FormInputViewModel in
                
                let validationService = FormInputValidationService(
                    changedClosure: { string -> (ValidationResult) in
                        
                        if Int(string) == nil {
                            return .failed(message: "Only numbers allowed")
                        }
                        return .ok
                })
                
                return FormInputViewModel(text: nil, placeholder: "Groupped field \(int)...", validationService: validationService)
        }
        
        let statesViews = inputViewModels
            .map(FormFieldView.init)
            .map(FieldStatesView.init)
        
        let stackView = UIStackView(arrangedSubviews: statesViews)
        stackView.axis = .vertical
        stackView.spacing = 16
        
        let validationService = FormGroupInputValidationService { values -> ValidationResult in
            if values.compactMap({ $0 }).count < 2 {
                return .failed(message: "Minimum 2 fields required")
            }
            return .ok
        }

        let viewMoodel = GroupFormViewModel(inputViewModels: inputViewModels, validationService: validationService)
        let view = GroupFormView(viewModel: viewMoodel)
        
        view.addFieldViews(stackView)
        
        fieldStatesView.formGroupView = view
    }
    */
}

class CheckboxValidation {
    
    static var validateEmpty: (Bool) -> (FormValidationResult) = { isOn in
        
//        guard isOn else  {
//            return .failed(message: "Field cannot be empty")
//        }

        return .ok
    }
}

