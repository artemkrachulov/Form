//
//  FormValidationResult.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

public enum FormValidationResult {
    case ok
    case failed(FormError)
}

extension FormValidationResult {
    
    public var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
