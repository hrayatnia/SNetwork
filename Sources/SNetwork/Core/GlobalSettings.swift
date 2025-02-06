//
//  RestGlobalConfiguration.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//
import Foundation

protocol Settings: Sendable {
    var baseURL: URL { get }
    var configuration: Configuration { get }
    var headers: any NetworkHeader { get }
    var validator: Array<any Validator> { get }
}


struct NetworkSettingsContainerRegistry: ContainerRegistry {
    var container: [String : any Settings] = [:]
    
    static let shared = NetworkSettingsContainerRegistry()
    
    mutating func register<T>(_ type: T.Type, _ value: any Settings) {
        container[String(describing: type)] = value
    }
}
