//
//  RequestTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//
import Foundation
import Testing
@testable import SNetwork

@Suite("Requestable Types Tests")
struct RequestableTests {
    
    @Test
    func httpMethodsTest() {
        let httpMethods: [HTTPMethod] = HTTPMethod.allCases
        #expect(httpMethods.count == 6)
        #expect(HTTPMethod.POST.rawValue == "POST")
    }
    
    @Test
    func urlRequestTest() {
        let urlString = "https://www.google.com"
        guard let url = URL(string: urlString) else {
            Issue.record("Invalid URL string")
            return
        }
        
        var request = URLRequest(url: url)
        request = request.applying(HTTPMethod.GET)
        
        #expect(request.url == url)
        #expect(request.httpMethod == "GET")
    }
    
    @Test
    func queryItemTest() {
        let baseURL = URL(string: "https://api.example.com")!
        var request = URLRequest(url: baseURL)
        let queryItem = URLQueryItem(name: "page", value: "1")
        
        request = queryItem.apply(to: request)
        
        #expect(request.url?.absoluteString == "https://api.example.com?page=1")
    }
    
    @Test
    func dataRequestTest() {
        let baseURL = URL(string: "https://api.example.com")!
        var request = URLRequest(url: baseURL)
        let requestData = "test body".data(using: .utf8)!
        
        request = requestData.apply(to: request)
        
        #expect(request.httpBody == requestData)
    }
    
    @Test
    func uriPathTest() {
        let baseURL = URL(string: "https://api.example.com")!
        var request = URLRequest(url: baseURL)
        let uriPath: URIPath = "/users"
        
        request = uriPath.apply(to: request)
        
        #expect(request.url?.absoluteString == "https://api.example.com/users")
    }
}
