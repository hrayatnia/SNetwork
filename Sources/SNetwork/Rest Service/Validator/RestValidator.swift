//
//  RestValidator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

import Foundation


public protocol RestValidator: Validator, Sendable {}

public protocol RestRequestValidator: RestValidator, Sendable where Input: Destination {
    func validateAny(_ value: Any) throws
}


public protocol RestResponseValidator: RestValidator, Sendable {}

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
