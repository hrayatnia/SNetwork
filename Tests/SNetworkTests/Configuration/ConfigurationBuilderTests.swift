//
//  ConfigurationBuilderTests.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Testing
import Foundation
@testable import SNetwork

@Suite("Configuration Builder Tests")
struct ConfigurationBuilderTests {
    
    @Test("build default configuration")
    func buildDefaultConfiguration() {
        var configuration: Configuration = .init()
        #expect(configuration.type == .default)
        configuration = .init(type: .ephemeral)
        #expect(configuration.type == .ephemeral)
        configuration = .init(type: .background(""))
        #expect(configuration.type == ConfigurationType.background(""))
        
    }
    
    
    @Test("header setting test")
    func testSetHeader() {
        var header = TestNetworkHeader()
        header.Authorization = "Bearer token"
        let config = Configuration()
            .set(header)
        
        let builtConfig = config.build
        let headers = builtConfig.httpAdditionalHeaders as? [String: String]
        
        #expect(headers?["Authorization"] == "Bearer token")
    }
    
    @Test("ensure cache policy is set correctly")
    func testSetCachePolicy() {
        let config = Configuration()
            .set(.reloadIgnoringLocalCacheData)
        
        let builtConfig = config.build
        
        #expect(builtConfig.requestCachePolicy == .reloadIgnoringLocalCacheData)
    }
    
    @Test("validate timeout interval")
    func testSetTimeoutInterval() {
        let timeout: TimeInterval = 30
        let config = Configuration()
            .set(timeout)
        
        let builtConfig = config.build
        
        #expect(builtConfig.timeoutIntervalForRequest == timeout)
    }
    
    @Test("cache policy is set correctly")
    func testSetURLCache() {
        let urlCache = URLCache(memoryCapacity: 51200, diskCapacity: 102400, diskPath: nil)
        let config = Configuration()
            .set(urlCache)
        
        let builtConfig = config.build
        
        #expect(builtConfig.urlCache === urlCache)
    }
    
    @Test("check if cookies are allowed")
    func testAllowingCookies() {
        let config = Configuration()
            .allowingCookies(true)
        
        let builtConfig = config.build
        
        #expect(builtConfig.httpShouldSetCookies == true)
    }
    
    @Test("check allowing cellular access is set correctly")
    func testAllowingCellularAccess() {
        let config = Configuration()
            .allowingCellularAccess(false)
        
        let builtConfig = config.build
        
        #expect(builtConfig.allowsCellularAccess == false)
    }
    
    @Test("allow to wait for connectivity")
    func testWaitingForConnectivity() {
        let config = Configuration()
            .waitingForConnectivity(true)
        
        let builtConfig = config.build
        
        #expect(builtConfig.waitsForConnectivity == true)
    }
    
    @Test("set request timeout")
    func testSetRequestTimeout() {
        let timeout: TimeInterval = 60
        let config = Configuration()
            .set(requestTimeout: timeout)
        
        let builtConfig = config.build
        
        #expect(builtConfig.timeoutIntervalForRequest == timeout)
    }
    
    @Test
    func testSetResponseTimeout() {
        let timeout: TimeInterval = 120
        let config = Configuration()
            .set(responseTimeout: timeout)
        
        let builtConfig = config.build
        
        #expect(builtConfig.timeoutIntervalForResource == timeout)
    }
    
    @Test
    func testUsingHTTPPipelining() {
        let config = Configuration()
            .usingHTTPPipelining(true)
        
        let builtConfig = config.build
        
        #expect(builtConfig.httpShouldUsePipelining == true)
    }
    
    @Test
    func testSetCustomProperty() {
        var config = Configuration()
        config.set(\.allowsExpensiveNetworkAccess, to: false)
        let builtConfig = config.build
        
        #expect(builtConfig.allowsExpensiveNetworkAccess == false)
    }
}

struct TestNetworkHeader: NetworkHeader {
    
    enum TestNetworkHeaderKey: String {
        case test
    }
    
    var headers: [String : AnyHashable]  = [TestNetworkHeaderKey.test.rawValue: ""]
    
}
