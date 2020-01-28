//
//  FormFieldViewModel.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

public class FormFieldViewModel: NSObject {
    
    // MARK: -
    // MARK: ** Properties **
    
    var autoSetError: Bool = false
    
    var isEnabled: Bool {
        didSet { setEnabled?(isEnabled)  }
    }
    var setEnabled: ((Bool) -> Void)? {
        didSet { setEnabled?(isEnabled) }
    }
    
    var validationResult: FormValidationResult = .ok {
        didSet { setValidationResult?(validationResult) }
    }

    var setValidationResult: ((FormValidationResult) -> Void)? {
        didSet { setValidationResult?(validationResult) }
    }
    
    func splitValidationResult(ok: ()->Void, error: (String)->Void ) {

        if case let .failed(text) = validationResult {
            guard autoSetError else {
                ok()
                return
            }
            error(text.localizedDescription)
        } else {
            autoSetError = false
            ok()
        }
    }
    
    var isValid: Bool {
        if isEnabled { return validationResult.isValid
        } else { return true }
    }
    
    init(isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
    
    // MARK: -
    // MARK: ** Helper methods **
    
    func showErrorIfExist() {
        autoSetError = true
        setValidationResult?(validationResult)
    }
    
    var setClear: (() -> Void)?
    
    func clear() {
         autoSetError = false
         setClear?()
     }
}

enum FormFieldError: Error {
    case error(String)
}
