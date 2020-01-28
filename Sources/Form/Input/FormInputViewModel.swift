//
//  FormInputViewModel.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormInputViewModel: FormFieldValueViewModel<String?> {

    // MARK: -
    // MARK: ** Properties **
    
    public let placeholderLabelText: String?
    
    public var isHighlighted: Bool = false {
        didSet { setHighlighted?(isHighlighted) }
    }
    
    var setHighlighted: ((Bool) -> Void)?
    var setPlaceholderLabelHidden: ((Bool) -> Void)?
    
    // MARK: -
    // MARK: ** Initialization **

    public init(text: String?, placeholder: String?, required: FormValidator<String?>? = nil, changed: FormValidator<String?>? = nil, isEnabled: Bool = true) {

        self.placeholderLabelText = placeholder
        super.init(text, closure: { $0 ?? "" != $1 ?? "" }, isEnabled: isEnabled)
        
        didChange = { [weak self] (change, value) in
            guard let strongSelf = self else { return }
            
            let value = value ?? ""
            let isEmpty = value.isEmpty
            
            if isEmpty {
                strongSelf.baseViewModel.autoSetError = false
            }

            if let required = required, value.isEmpty {
                strongSelf.validationResult = validate(value, using: required)
            }

            if let changed = changed, !value.isEmpty {
                strongSelf.validationResult = validate(value, using: changed)
            }
            
            strongSelf.setPlaceholderLabelHidden?(isEmpty)

            //
            strongSelf.didChangeModel?(value, change, strongSelf.baseViewModel.validationResult, strongSelf.baseViewModel.isValid)
        }
    }
}

extension FormValidator where Value == String? {
    
    public static var ok: FormValidator {
        return FormValidator { _ in }
    }
}
