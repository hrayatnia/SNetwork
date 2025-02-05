//
//  TestRestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Testing
@testable import SNetwork


internal struct TestRestService: RestService {
    typealias Response = RestTestResponse
    private(set) internal var request: String
    let destination: String
    
    
    func send() async throws -> Response {
        try await Task.sleep(nanoseconds: 100_000_000)
        return .init(text: "")
    }
    
}


internal struct RestTestResponse: Decodable, Sendable {
    let text: String
}
