//
//  TestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 03.02.25.
//
@testable import SNetwork
import Foundation

// Mock Service Implementation for Testing
struct TestService: AnyService {
    var request: String
    
    typealias Response = String
    
    func send() async throws -> String {
        try await Task.sleep(nanoseconds: 100_000_000)
        return request + "!"
    }
}


struct ErrorService: AnyService {
    var request: String
    typealias Response = String
    
    func send() async throws -> String {
        throw NSError()
    }
}
