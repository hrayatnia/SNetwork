//
//  Session.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//
import Foundation

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public protocol Session: ~Copyable, Sendable {
    associatedtype ConfigurationType: Configuration
    var session: URLSession { get }
    var configuration: ConfigurationType { get }
}

@frozen
@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public struct NetworkSession:~Copyable, Session {
    public typealias ConfigurationType = NetworkConfiguration

    private(set) public var session: URLSession
    
    public let configuration: ConfigurationType
    
    init(session: URLSession, configuration: ConfigurationType) {
        self.session = session
        self.configuration = configuration
    }
}



