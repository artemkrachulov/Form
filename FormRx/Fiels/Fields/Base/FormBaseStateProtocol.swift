//
//  FormBaseStateProtocol.swift
//  Form
//
//  Created by Artem on 8/9/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//


protocol FormBaseStateProtocol where Self: UIView {
    func setOk()
    func setError(_ errorText: String)
    func setEnabled(_ isEnabled: Bool)
}

extension Reactive where Base: FormBaseStateProtocol {
    
    var validationResult: Binder<ValidationResult> {
        return Binder(self.base, binding: { (view, validationResult) in
            if case let .failed(text) = validationResult {
                view.setError(text)
            } else {
                view.setOk()
            }
        })
    }
    
    var isEnabled: Binder<Bool> {
        return Binder(self.base, binding: { (view, isEnabled) in
            view.setEnabled(isEnabled)
        })
    }
}
