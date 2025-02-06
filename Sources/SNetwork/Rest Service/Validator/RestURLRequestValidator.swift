//
//  RestURLRequestValidator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

import Foundation

public struct RestURLRequestValidator: RestValidator {
    var isRequest: Bool = true
    
    
    func validate(_ value: Destination) throws {
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

