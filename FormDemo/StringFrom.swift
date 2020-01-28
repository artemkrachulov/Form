//
//  StringFrom.swift
//  FormDemo
//
//  Created by Artem on 9/2/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import Foundation

func stringFrom(_ int: Int?) -> String? {
    guard let int = int else {
        return nil
    }
    return String(int)
}

func stringFrom(_ double: Double?) -> String? {
    guard let double = double else {
        return nil
    }
    return String(double)
}

func unwrap<T>(_ array: [T]?) -> [T] {
    return array ?? []
}
