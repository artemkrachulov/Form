//
//  FormValueViewModel.swift
//  Form
//
//  Created by Artem on 10/31/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//


open class FormValueViewModel<T: Equatable>: NSObject {
    
    public let valueOriginal: T
    
    public let rxValue: BehaviorRelay<T>
    public var value: T {
        return rxValue.value
    }

    public let rxIsChanged: Driver<Bool>
    public var isChanged: Bool {
        return closure(rxValue.value, valueOriginal)
    }
    
    private let closure: (_ original: T, _ new: T) -> Bool
    
    public init(value: T, closure: @escaping ((_ original: T, _ new: T) -> Bool)) {
        self.valueOriginal = value
        self.closure = closure
        self.rxValue = BehaviorRelay<T>(value: value)
        self.rxIsChanged = Driver.combineLatest(Driver.just(value), rxValue.asDriver(), resultSelector: closure)
    }
    
    public func setNewValue(_ value: T) {
        rxValue.accept(value)
    }
}
