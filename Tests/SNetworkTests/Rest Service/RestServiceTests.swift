//
//  RestServiceTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Testing
@testable import SNetwork

@Suite("Rest Service Layer Tests")
struct RestServiceTests {
    
    
    @Test func testSendMockData() async throws {
        let service = MockRestService(request: "")
        _ = try await service.send()
    }
}
