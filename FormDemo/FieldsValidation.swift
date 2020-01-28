//
//  FieldsValidation.swift
//  FormDemo
//
//  Created by Artem on 08.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Form

class FieldsValidation {

    static func validateRepeatedEmail(string: String?, repeatedString: String?) -> FormValidationResult {
        
        if let repeatedString = repeatedString, repeatedString.count == 0 {
            return .failed(FormError(message: "Field cannot be empty"))
        }
        if repeatedString == string {
            return .ok
        } else {
            return .failed(FormError(message: "Email different"))
        }
    }
}

extension FormValidator where Value == String? {
    static var empty: FormValidator {
        return FormValidator { string in
            
            let string = string ?? ""
            
            try validate(
                !string.isEmpty,
                errorMessage: "Field cannot be empty"
            )
        }
    }
}

extension FormValidator where Value == String? {

    static var email: FormValidator {
        return FormValidator { string in
            
            let string = string ?? ""
                
            try validate(
                !string.isEmpty,
                errorMessage: "Field cannot be empty"
            )
            
            let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
            
            try validate(
                validateString(string, pattern: emailPattern),
                errorMessage: "Email is wrong"
            )
        }
    }
    
    private static func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
