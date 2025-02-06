//
//  RestValidator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol RestValidator: Validator, Sendable {}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol RestRequestValidator: RestValidator, Sendable where Input: Destination {
    func validateAny(_ value: Any) throws
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol RestResponseValidator: RestValidator, Sendable {}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol RestResponseHeaderValidator: RestResponseValidator, Sendable {
    func validateAny(_ value: Any) throws
}

extension RestValidator {
    var isHeader: Bool {
        self is (any RestResponseHeaderValidator)
    }
}

extension RestValidator {
    var isRequest: Bool {
        self is (any RestRequestValidator)
    }
}

public extension RestValidator {
    func validateAny(_ value: Any) throws {
        guard let castedValue = value as? Input else {
            throw NSError(domain: "Type mismatch", code: -1, userInfo: nil)
        }
        try validate(castedValue)
    }
}
