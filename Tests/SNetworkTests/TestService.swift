//
//  TestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 03.02.25.
//
@testable import SNetwork
import Foundation

struct TestService: AnyService {
   

    typealias Request = String
    typealias Response = String
    
    let request: String
    
    init(_ request: String) {
        self.request = request
    }
    
    func send() async throws -> Response {
        try await Task.sleep(nanoseconds: 1_000_000)
        return request + "!"
    }
}
