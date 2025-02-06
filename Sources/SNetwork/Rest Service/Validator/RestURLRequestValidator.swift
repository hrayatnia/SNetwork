//
//  RestURLRequestValidator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public struct RestURLRequestValidator: RestRequestValidator {
    
    public func validate(_ value: Destination) throws {
        guard let url = value.url,
        let scheme = url.scheme,
        let host = url.host,
        !scheme.isEmpty,
        !host.isEmpty else {
            throw ValidationError.invalidType
        }
    }
    
    enum ValidationError: LocalizedError {
        case invalidType
    }
}

