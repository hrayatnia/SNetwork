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
    
    @available(macOS 13.0, *)
    func send() async throws -> Self.Response {
        // get configuration and settings
        let settings = self.settings
        let session = self.session
        let destionation =  self.destination
        
        // build request
        // TODO make the encoder generic
        destionation.httpBody = try? JSONEncoder().encode(request)
        
        // validate request
        settings
            .validator
            .filter { $0.isRequest }
            .compactMap { $0 as? (any RestRequestValidator) }
            .forEach { try? $0.validateAny(destination) }
        
        guard let (data, response): (Data, URLResponse) = try? await session.session.data(for: destionation.toUrlRequest) else {
            fatalError()
        }
        
        // validate headers
        settings.validator
            .filter { $0.isHeader }
            .compactMap { $0 as? (any RestResponseHeaderValidator) }
            .forEach { try? $0.validateAny(response) }
        // decode body
        let decodedData = try? settings.decoder.decode(Response.self, from: data)
        
        // validate body
        settings.validator
            .filter { !$0.isHeader }
            .compactMap { $0 as? (any RestResponseHeaderValidator) }
            .forEach { try? $0.validateAny(decodedData) }
        
        // return result
        return decodedData!
        
    }
    
    private var session: NetworkSession {
        guard let session = NetworkSessionContainerRegistry.shared.resolve(Self.self) as? NetworkSession else {
            fatalError("Session not found for \(Self.self) in the container registry.")
        }
        return session
    }
    
    @available(macOS 13.0, *)
    internal var settings: RestSettings<JSONDecoder> {
        guard let settings = NetworkSettingsContainerRegistry.shared.resolve(Self.self) as? RestSettings<JSONDecoder> else {
            fatalError("Settings not found for \(Self.self) in the container registry.")
        }
        return settings
    }
    
}

