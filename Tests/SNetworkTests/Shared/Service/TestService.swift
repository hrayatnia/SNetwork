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
    
    typealias Response = String
    
    let request: String
    
    let destination: String
    
    func send() async throws -> String {
        try await Task.sleep(nanoseconds: 100_000_000)
        return request + "!"
    }
}


struct ErrorService: AnyService {
   
    typealias Response = Void
    
    let request: Void
    let destination: Void
    
    func send() async throws -> Void {
        throw NSError()
    }
}
