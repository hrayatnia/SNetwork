//
//  RestGlobalConfiguration.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//
import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol Settings: Sendable {
    associatedtype ValidatorType
    var baseURL: URL { get }
    var validator: Array<ValidatorType> { get }
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public struct NetworkSettingsContainerRegistry: ContainerRegistry, Sendable {
    var container: [String : any Settings] = [:]
    
    public static let shared = NetworkSettingsContainerRegistry()
    
    public mutating func register<T>(_ type: T.Type, _ value: any Settings) {
        container[String(describing: type)] = value
    }
}
