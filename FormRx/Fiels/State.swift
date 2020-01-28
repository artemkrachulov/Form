//
//  State.swift
//  Form
//
//  Created by Artem on 7/25/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import Foundation

public enum ValidationResult: Equatable {
    case ok
    case failed(message: String)
}

extension ValidationResult {
    
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

open class FormInputValidationService {
    
    public let isOptional: Bool
    public let settings: FormInputSettings
    
    let requiredClosure: ((String?) -> ValidationResult)?
    let changedClosure: ((String) -> ValidationResult)?
    
    public init(settings: FormInputSettings, requiredClosure: ((String?) -> (ValidationResult))? = nil, changedClosure: ((String) -> (ValidationResult))? = nil) {
        
        self.isOptional = requiredClosure == nil
        self.settings = settings
        
        self.requiredClosure = requiredClosure
        self.changedClosure = changedClosure
    }
    
    func valueValidate(string: String?, isEnabled: Bool) -> ValidationResult {
    
        if !isEnabled { return .ok }
        
        if let requiredClosure = requiredClosure {
            let ccc = requiredClosure(string)
            if ccc != .ok { return ccc }
        }
        
        if let string = string, !string.isEmpty, let changedClosure = changedClosure {
            return changedClosure(string)
        }

        return .ok
    }
    
    public static var disabled: FormInputValidationService {
        return FormInputValidationService(settings: .allEnabled)
    }
}

open class FormGroupInputValidationService {
    
    let requiredClosure: (([String?]) -> ValidationResult)?
    
    public init(requiredClosure: (([String?]) -> ValidationResult)? = nil) {
        self.requiredClosure = requiredClosure
    }
    
    func valueValidate(string: [String?], isEnabled: Bool) -> ValidationResult {
    
        if !isEnabled { return .ok }
        
        if let requiredClosure = requiredClosure {
            let ccc = requiredClosure(string)
            if ccc != .ok { return ccc }
        }
        
        return .ok
    }
    
    
    public static var disabled: FormGroupInputValidationService {
        return FormGroupInputValidationService()
    }
}
