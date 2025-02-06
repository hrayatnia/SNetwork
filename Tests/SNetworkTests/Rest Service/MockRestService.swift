//
//  TestRestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Foundation
@testable import SNetwork


internal struct MockRestService: RestService {
    typealias Response = RestTestResponse
    private(set) internal var request: String
    let destination: SNetwork.Destination = "https://google.com".destination
    
    func send() async throws -> RestTestResponse {
        return .init(text: "Hello World")
    }
    
    
}


internal struct RestTestResponse: Decodable, Sendable {
    let text: String
}



