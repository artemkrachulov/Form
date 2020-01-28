//
//  FormBaseSettings.swift
//  Connect2Treat
//
//  Created by Artem on 11/25/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import Foundation

public class FormBaseSettings {
    
    let resetAutoWhenOk: Bool
    let validateWhenError: Bool
    let hideWhenDisabled: Bool = true
    
    public init(resetAutoWhenOk: Bool, validateWhenError: Bool) {
        self.resetAutoWhenOk = resetAutoWhenOk
        self.validateWhenError = validateWhenError
    }
}
