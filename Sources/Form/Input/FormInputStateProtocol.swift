//
//  FormInputStateProtocol.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

protocol FormInputStateProtocol: FormFieldStateProtocol {
    func setHighlighted(_ isHighlighted: Bool)
}
