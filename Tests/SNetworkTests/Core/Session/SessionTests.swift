//
//  SessionTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Testing
import Foundation
@testable import SNetwork

@Suite("Network Session Tests")
public struct SessionTests {
    
    
    @Test("")
    func testSessionCreation() {
        var session = NetworkSession(configuration: .init())
    }
    
}
