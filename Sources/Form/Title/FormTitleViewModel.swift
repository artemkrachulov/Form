//
//  FormTitleViewModel.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

open class FormTitleViewModel {
    
    let titleLabelText: String?
    let requiredLabelText: String
    let optionalLabelText: String
    let showRequiredLabel: Bool
    
    let isOptional: Bool
    
    public init(titleText: String?, isOptional: Bool, showRequiredLabel: Bool = true) {
        self.titleLabelText = titleText
        self.optionalLabelText = "(Optional)"
        self.requiredLabelText = "*"
        self.showRequiredLabel = showRequiredLabel
        self.isOptional = isOptional
//        self.isOptional = showRequiredLabel ? isOptional : !isOptional
    }
}

