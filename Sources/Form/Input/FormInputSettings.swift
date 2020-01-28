//
//  FormInputSettings.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

open class FormInputSettings {
    
    // MARK: -
    // MARK: ** Properties **
    
    public let baseSettings: FormFieldSettings
    public let resetWhenEmpty: Bool
    
    public static var allEnabled: FormInputSettings {
        return .init(resetWhenEmpty: true, resetWhenOk: true)
    }
    
    // MARK: -
    // MARK: ** Initialization **
    
    public init(resetWhenEmpty: Bool, resetWhenOk: Bool) {
        self.baseSettings = .init(resetWhenOk: resetWhenOk)
        self.resetWhenEmpty = resetWhenEmpty
    }
}

