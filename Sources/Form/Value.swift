//
//  Value.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

open class Value<T: Equatable> {
    
    let oldValue: T
    private let closure: (_ original: T, _ new: T) -> Bool
    
    public init(_ value: T, closure: @escaping ((_ original: T, _ new: T) -> Bool)) {
        self.value = value
        self.oldValue = value
        self.closure = closure
    }
    
    public var value: T {
        didSet {
            isChanged = closure(self.oldValue, value)
        }
    }

    public var isChanged: Bool = false {
        didSet {
            didChange?(isChanged, value)
        }
    }
        
    public var didChange: ((Bool, T) -> Void)? {
        didSet {
            didChange?(isChanged, value)
        }
    }
}
