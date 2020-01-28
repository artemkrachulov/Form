//
//  FormFieldViewModelData.swift
//  Form
//
//  Created by Artem on 08.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

public protocol FormFieldViewModelData: class {
    
    var baseViewModel: FormFieldViewModel { get }
}

extension FormFieldViewModelData {
    
    public var isEnabled: Bool {
        set { baseViewModel.isEnabled = newValue }
        get { return baseViewModel.isEnabled }
    }
    
    public var isValid: Bool {
        return baseViewModel.isValid
    }
    
    public func showErrorIfExist() {
        baseViewModel.showErrorIfExist()
    }
    
    public func clear() {
        baseViewModel.clear()
    }
    
    public var validationResult: FormValidationResult  {
        set { baseViewModel.validationResult = newValue }
        get { return baseViewModel.validationResult }
    }
}
