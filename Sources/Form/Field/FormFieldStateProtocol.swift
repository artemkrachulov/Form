//
//  FormFieldStateProtocol.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit

protocol FormFieldStateProtocol where Self: UIView {

    func setOk()
    func setError(_ errorText: String)
    func setEnabled(_ isEnabled: Bool)
}
