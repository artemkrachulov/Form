//
//  FormCheckboxStateProtocol.swift
//  Form
//
//  Created by Artem on 01.12.2019.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import Foundation

protocol FormCheckboxStateProtocol: FormFieldStateProtocol {
    func setChecked(_ isChecked: Bool)
}
