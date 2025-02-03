//
//  AnyServiceTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 03.02.25.
//

import Testing
import Foundation
@testable import SNetwork

@Suite("Service Layer")
struct ServiceLayerTests {
    
    // Test for the basic `send()` function (async)
    @Test("Test send() async function", arguments: [TestService(request: "Hello World")]) func testSendAsyncFunction(_ service: TestService) async throws {
        let response = try await service.send()
        #expect(response == "\(service.request)!")
    }
    
    // Test for the `send()` function returning a Task
    @Test("Test send() returning a Task", arguments: [TestService(request: "Hello World")]) func testSendReturningTask(_ service: TestService) async throws {
        let task: Task<String, Error> = service.send()
        let response = try await task.value
        #expect(response == "\(service.request)!")
    }
    
    // Test for the `send()` function returning a Result
    @Test("Test send() returning a Result", arguments: [TestService(request: "Hello World")]) func testSendReturningResult(_ service: TestService) throws {
        let result: Result<String, Error> = service.send()
        
        switch result {
        case .success(let response):
            #expect(response == "\(service.request)!")
        case .failure(let error):
            throw error
        }
    }
    
    // Test handling errors in send()
    @Test("Test send() throws error") func testSendThrowsError() async throws {
        let service = ErrorService(request: "Hello")
        
        do {
            let result = try await service.send()
            #expect(result != "Hello World")
        } catch {
            #expect(error is NSError)
        }
    }
}
