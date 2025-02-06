//
//  RestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Foundation


@available(iOS 12.0, macOS 10.14, tvOS 12.0, *)
public protocol RestService: AnyService where Response: Decodable,
                                               Request: Encodable,
                                               Destination: SNetwork.Destination {
}


public extension RestService {
    
    func send() async throws -> Self.Response {
        preconditionFailure()
    }
    
    var session: NetworkSession {
        guard let session = NetworkSessionContainerRegistry.shared.resolve(Self.self) as? NetworkSession else {
            fatalError("Session not found for \(Self.self) in the container registry.")
        }
        return session
    }
    
    @available(macOS 13.0, *)
    var settings: RestSettings<JSONDecoder> {
        guard let settings = NetworkSettingsContainerRegistry.shared.resolve(Self.self) as? RestSettings<JSONDecoder> else {
            fatalError("Settings not found for \(Self.self) in the container registry.")
        }
        return settings
    }
}

