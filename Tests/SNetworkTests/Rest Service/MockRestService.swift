//
//  TestRestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Foundation
@testable import SNetwork


internal struct MockRestService: RestService {
    
    
    private(set) internal var request: String
    
    var destination: SNetwork.Destination {
        "/v1/test"
            .destination(settings.baseURL) // TODO: replace with property wrapper
            .applying(HTTPMethod.GET)
    }
    
    func send() async throws -> RestTestResponse {
        return .init(text: "Hello World")
    }
    
    
}


internal struct RestTestResponse: Decodable, Sendable {
    let text: String
}



