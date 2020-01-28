//
//  FormInputStateProtocol.swift
//  Form
//
//  Created by Artem on 11/22/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//


protocol FormInputStateProtocol: FormBaseStateProtocol {
    func setHighlighted(_ isHighlighted: Bool)
}

extension Reactive where Base: FormInputStateProtocol {

    var isHighlighted: Binder<Bool> {
        return Binder(self.base, binding: { (view, isHighlighted) in
            view.setHighlighted(isHighlighted)
        })
    }
}
