//
//  FormFieldSettings.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

public class FormFieldSettings {
    
    // MARK: -
    // MARK: ** Properties **
    
    public let resetWhenOk: Bool

    // MARK: -
    // MARK: ** Initialization **
    
    public init(resetWhenOk: Bool) {
        self.resetWhenOk = resetWhenOk
    }
}
