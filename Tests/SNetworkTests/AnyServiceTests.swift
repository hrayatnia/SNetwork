//
//  AnyServiceTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 03.02.25.
//

import Testing
@testable import SNetwork


@Suite("Service Layer")
struct ServiceLayerTests {
    
    
    @Test("Test Service", arguments: [TestService("Hello World")]) func AnyServiceRunFunction(_ service: TestService) async throws {
        #expect(try await service.send() == "Hello World!")
    }
}
