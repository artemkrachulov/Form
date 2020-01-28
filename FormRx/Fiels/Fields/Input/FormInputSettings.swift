//
//  FormInputSettings.swift
//  Connect2Treat
//
//  Created by Artem on 11/25/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import Foundation

open class FormInputSettings {
    
    let baseSettings: FormBaseSettings
    let resetOnEmpty: Bool
    
    public init(resetOnEmpty: Bool, resetAutoWhenOk: Bool, validateWhenError: Bool) {
        self.baseSettings = .init(resetAutoWhenOk: resetAutoWhenOk, validateWhenError: resetAutoWhenOk)
        self.resetOnEmpty = resetOnEmpty
    }
    
    public static var allEnabled: FormInputSettings {
        return .init(resetOnEmpty: true, resetAutoWhenOk: true, validateWhenError: true)
    }
}
