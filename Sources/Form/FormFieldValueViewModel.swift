//
//  FormFieldValueViewModel.swift
//  Form
//
//  Created by Artem on 27.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

open class FormFieldValueViewModel<T: Equatable>: Value<T>, FormFieldViewModelData {
    
    public let baseViewModel: FormFieldViewModel
    
    public var didChangeModel: ((T, Bool, FormValidationResult, Bool) -> Void)? {
        didSet { didChangeModel?(value, isChanged, baseViewModel.validationResult, baseViewModel.isValid) }
    }
    
    public init(_ value: T, closure: @escaping ((_ original: T, _ new: T) -> Bool), isEnabled: Bool = true) {
        self.baseViewModel = FormFieldViewModel(isEnabled: isEnabled)
        super.init(value, closure: closure)
    }
    
    func setEnabled(_ isEnabled: Bool) {
        didChangeModel?(value, isChanged, baseViewModel.validationResult, baseViewModel.isValid)
    }
    
    public func getValue() throws -> T {
        guard case let .failed(error) = baseViewModel.validationResult else { return value }
        throw error
    }
}
