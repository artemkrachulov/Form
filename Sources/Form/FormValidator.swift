//
//  FormValidator.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import Foundation

public struct FormValidator<Value> {
    public let closure: (Value) throws -> Void
    
    public init(closure: @escaping (Value) throws -> Void) {
        self.closure = closure
    }
}

public struct FormError: LocalizedError {
    public let message: String
    public var errorDescription: String? { return message }
    
    public init(message: String) {
        self.message = message
    }
}

public func validate(_ condition: @autoclosure () -> Bool, errorMessage messageExpression: @autoclosure () -> String) throws {
    guard condition() else {
        let message = messageExpression()
        throw FormError(message: message)
    }
}

public func validate<T>(_ value: T, using validator: FormValidator<T>) -> FormValidationResult {
    do {
        try validator.closure(value)
        return .ok
    } catch let error as FormError {
        return .failed(error)
    } catch {
        return .failed(FormError(message: error.localizedDescription))
    }
}
