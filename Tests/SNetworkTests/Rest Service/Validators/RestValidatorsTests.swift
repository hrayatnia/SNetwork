//
//  RestValidatorsTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

import Testing
import Foundation
@testable import SNetwork
import XCTest

@Suite("Rest Validators Tests")
struct RestValidatorsTests {
    
    // MARK: - RestStatusCodeValidator Tests
    
    @Test("Valid status codes do not throw errors")
    func testValidStatusCodes() throws {
        let validStatusCodes: [(Int, URL)] = [
            (200, URL(string: "http://example.com")!),
            (201, URL(string: "http://example.com")!),
            (202, URL(string: "http://example.com")!),
            (204, URL(string: "http://example.com")!)
        ]
        
        let validator = RestStatusCodeValidator()
        
        for (statusCode, url) in validStatusCodes {
            #expect(throws: Never.self) { try validator.validate((statusCode, url)) }
        }
    }
    
    @Test("Invalid status codes throw appropriate errors")
    func testInvalidStatusCodes() throws {
        let invalidStatusCodes: [(Int, URL)] = [
            (400, URL(string: "http://example.com")!),
            (404, URL(string: "http://example.com")!),
            (500, URL(string: "http://example.com")!)
        ]
        
        let validator = RestStatusCodeValidator()
        
        for (statusCode, url) in invalidStatusCodes {
            #expect(throws: HTTPStatusCodeError.self) {
                    try validator.validate((statusCode, url))
            }
        }
    }
    
    @Test("Invalid status code should throw error when invalid status code is passed")
    func testInvalidStatusCodeThrowsBadServerResponseError() throws {
        let invalidStatusCode = 999
        let url = URL(string: "http://example.com")!
        
        let validator = RestStatusCodeValidator()
        
        #expect(throws: URLError.self) {
            try validator.validate((invalidStatusCode, url))
        }
    }
    
    // MARK: - RestURLRequestValidator Tests
    
    @Test("Valid URLs should pass validation")
    func testValidURLs() throws {
        let validURLs: [Destination] = [
            Destination(url: URL(string: "http://example.com")!),
            Destination(url: URL(string: "https://example.com")!),
            Destination(url: URL(string: "ftp://example.com")!)
        ]
        
        let validator = RestURLRequestValidator()
        
        for destination in validURLs {
            #expect(throws: Error.self){ try validator.validateAny(destination) }
        }
    }
    
    @Test("Invalid URLs should throw validation error")
    func testInvalidURLs() throws {
        let invalidURLs: [Destination] = [
            Destination(url: URL(string: "ht://example.com")!),
            Destination(url: URL(string: "://example.com")!)
        ]
        
        let validator = RestURLRequestValidator()
        
        for destination in invalidURLs {
            #expect(throws: Error.self){ try validator.validateAny(destination) }
        }
    }
    
    // MARK: - Test Helpers
    
    // Destination structure to be used in URL validation tests
    struct Destination {
        var url: URL
    }
}
