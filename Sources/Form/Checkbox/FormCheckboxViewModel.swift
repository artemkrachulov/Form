//
//  FormCheckboxViewModel.swift
//  Connect2Treat
//
//  Created by Artem on 01.12.2019.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormCheckboxViewModel: FormFieldValueViewModel<Bool> {
    
    // MARK: -
    // MARK: ** Properties **
    
    public let labelText: String

    // MARK: -
    // MARK: ** Initialization **
    
    public init(isOn: Bool, text: String, required: FormValidator<Bool>? = nil, isEnabled: Bool = true) {
        
        self.labelText = text
        super.init(isOn, closure: { $0 != $1 }, isEnabled: isEnabled)
        
        didChange = { [weak self] (change, value) in
            guard let strongSelf = self else { return }
            
            if let required = required, !value {
                strongSelf.validationResult = validate(value, using: required)
            }
            
            //
            strongSelf.didChangeModel?(value, change, strongSelf.baseViewModel.validationResult, strongSelf.baseViewModel.isValid)
        }
    }
}

extension FormCheckboxView {
    
    @objc public func switchDidChange(_ sswitch: UISwitch) {
        viewModel.value = sswitch.isOn
        setChecked(sswitch.isOn)
    }
}

extension FormValidator where Value == Bool {
    
    public static var ok: FormValidator {
        return FormValidator { _ in }
    }
}
