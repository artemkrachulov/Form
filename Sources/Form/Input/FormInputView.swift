//
//  FormInputView.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormInputView: FormFieldView {
    
    // MARK: -
    // MARK: ** UI Components **
    
    var formInputView: UIView!
    
    // MARK: -
    // MARK: ** Properties **
    
    // ViewModels
    
    public var viewModel: FormInputViewModel! {
        didSet { setViewModel() }
    }
    
    public var inputViewHeight: CGFloat? {
        didSet {
            
            var heightConstraint = formInputView.constraints.first(where: { $0.identifier == "height" })
            
            if let height = inputViewHeight {
                
                if heightConstraint == nil {
                    heightConstraint = formInputView.heightAnchor.constraint(equalToConstant: height)
                    heightConstraint?.identifier = "height"
                    heightConstraint?.isActive = true
                } else {
                    heightConstraint?.constant = height
                }
            } else {
                guard let heightConstraint = heightConstraint else { return }
                formInputView.removeConstraint(heightConstraint)
            }
        }
    }
    
    // MARK: -
    // MARK: ** Setup methods **

    func setViewModel() {
        baseViewModel = viewModel.baseViewModel
    }
}
