//
//  Session.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//
import Foundation

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public protocol Session: Sendable {
    associatedtype ConfigurationType: Configuration
    var configuration: ConfigurationType { get }
}

@frozen
@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public struct NetworkSession: Session {
    
    public typealias ConfigType = NetworkConfiguration
    
    public let configuration: ConfigType
    
    private let session: URLSession
    
    init(configuration: ConfigType) {
        self.session =  URLSession(configuration: configuration.configuration)
        self.configuration = configuration
    }
    
    
}


struct NetworkSessionContainerRegistry: ContainerRegistry {
    var container: [String : any Session] = [:]
    
    static let shared: NetworkSessionContainerRegistry = .init()
    
    mutating func register<T>(_ type: T.Type, _ value: any Session) {
        container[String(describing: type)] = value
    }
    
}
