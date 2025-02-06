//
//  RestGlobalConfiguration.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//
import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
protocol Settings: Sendable {
    associatedtype ValidatorType
    var baseURL: URL { get }
    var validator: Array<ValidatorType> { get }
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
struct NetworkSettingsContainerRegistry: ContainerRegistry {
    var container: [String : any Settings] = [:]
    
    static let shared = NetworkSettingsContainerRegistry()
    
    mutating func register<T>(_ type: T.Type, _ value: any Settings) {
        container[String(describing: type)] = value
    }
}
