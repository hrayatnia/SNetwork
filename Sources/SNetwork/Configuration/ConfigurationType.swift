//
//  ConfigurationType.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

public enum ConfigurationType: Equatable {
    case `default`
    case ephemeral
    case background(String)
        
    internal func makeConfiguration() -> URLSessionConfiguration {
        switch self {
        case .default:
            return .default
        case .ephemeral:
            return .ephemeral
        case .background(let identifier):
            return URLSessionConfiguration.background(withIdentifier: identifier)
        }
    }
}
