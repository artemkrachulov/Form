//
//  Form2.swift
//  FormDemo
//
//  Created by Artem on 08.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Form

class Form2 {
    
    let field1: FormInputViewModel
    let field2: FormInputViewModel
//    let field3: FormInputViewModel
//    let field4: FormCheckboxViewModel
    
    init() {

        self.field1 = FormInputViewModel(text: nil, placeholder: "Field 1...", required: .empty, changed: .email)
        self.field2 = FormInputViewModel(text: nil, placeholder: "Field 2...", required: .empty)
        
 
        
        
        
//        self.field2.validationService = FormInputValidationService(
//        settings: .allEnabled,
//        requiredClosure: FieldsValidation.validateEmpty,
//        changedClosure: { _ in
//
//            print(self.field1.value)
//            return .ok
//        })
        

//        self.field1.didChangeModel = { [weak self] (value,_,_,isValid) in
//            guard let strongSelf = self else { return }
//            
//            strongSelf.updateValidationResult(value: strongSelf.field2.value)
//        }
//        
//        self.field2.didChangeModel = { [weak self] (value,_,_,isValid) in
//            guard let strongSelf = self else { return }
//            
//            strongSelf.updateValidationResult(value: value)
//        }
    }
    
    func updateValidationResult(value: String?) {
        
        let value = value ?? ""
        if !value.isEmpty {
//            field2.validationResult = FieldsValidation.validateRepeatedEmail(string: field1.value, repeatedString: value)
        }
    }
}
