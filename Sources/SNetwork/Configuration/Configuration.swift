//
//  Configuration.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation


/// A structure that provides a configurable wrapper around `URLSessionConfiguration`.
///
/// `Configuration` allows setting various networking parameters, including headers,
/// cache policies, timeouts, and connectivity options, in a fluent and immutable manner.
///
/// - Note: This struct is frozen and cannot be extended with new stored properties.
@frozen
@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public struct Configuration: Sendable {
    
    /// The underlying `URLSessionConfiguration` instance.
    private var configuration: URLSessionConfiguration
    
    /// The type of configuration being used.
    internal let type: ConfigurationType
    
    /// Initializes a new configuration with a specified type.
    ///
    /// - Parameter type: The configuration type, defaulting to `.default`.
    public init(type: ConfigurationType = .default) {
        self.configuration = type.makeConfiguration()
        self.type = type
    }
}

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public extension Configuration {
        
    /// Sets a network header.
    ///
    /// - Parameter header: The `NetworkHeader` to apply.
    /// - Returns: A new `Configuration` instance with the updated header.
    @discardableResult
    func set(_ header: some NetworkHeader) -> Self {
        configuration.httpAdditionalHeaders = header.headers
        return self
    }
    
    /// Sets the request cache policy.
    ///
    /// - Parameter cachePolicy: The cache policy to apply.
    /// - Returns: A new `Configuration` instance with the updated cache policy.
    @discardableResult
    func set(_ cachePolicy: URLRequest.CachePolicy) -> Self {
        configuration.requestCachePolicy = cachePolicy
        return self
    }
    
    /// Sets the request timeout interval.
    ///
    /// - Parameter timeoutInterval: The timeout interval for requests.
    /// - Returns: A new `Configuration` instance with the updated timeout interval.
    @discardableResult
    func set(_ timeoutInterval: TimeInterval) -> Self {
        configuration.timeoutIntervalForRequest = timeoutInterval
        return self
    }
    
    /// Sets the URL cache.
    ///
    /// - Parameter urlCache: The `URLCache` instance to use.
    /// - Returns: A new `Configuration` instance with the updated cache.
    @discardableResult
    func set(_ urlCache: URLCache?) -> Self {
        configuration.urlCache = urlCache
        return self
    }
    
    /// Configures whether cookies should be handled.
    ///
    /// - Parameter httpShouldHandleCookies: A Boolean value indicating cookie handling.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    func allowingCookies(_ shouldAllow: Bool) -> Self {
        configuration.httpShouldSetCookies = shouldAllow
        return self
    }
    
    /// Configures whether cellular access is allowed.
    ///
    /// - Parameter allowsCellularAccess: A Boolean value indicating cellular access.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    func allowingCellularAccess(_ isAllowed: Bool) -> Self {
        configuration.allowsCellularAccess = isAllowed
        return self
    }
    
    /// Configures whether the session should wait for connectivity.
    ///
    /// - Parameter waitForConnectivity: A Boolean value indicating waiting behavior.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    func waitingForConnectivity(_ shouldWait: Bool) -> Self {
        configuration.waitsForConnectivity = shouldWait
        return self
    }
    
    /// Sets the request timeout.
    ///
    /// - Parameter timeout: The request timeout interval.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    func set(requestTimeout timeout: TimeInterval) -> Self {
        configuration.timeoutIntervalForRequest = timeout
        return self
    }
    
    /// Sets the resource timeout.
    ///
    /// - Parameter timeout: The resource timeout interval.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    func set(responseTimeout timeout: TimeInterval) -> Self {
        configuration.timeoutIntervalForResource = timeout
        return self
    }
    
    /// Configures whether HTTP pipelining should be used.
    ///
    /// - Parameter httpShouldUsePipelining: A Boolean value indicating pipelining usage.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    func usingHTTPPipelining(_ shouldUse: Bool) -> Self {
        configuration.httpShouldUsePipelining = shouldUse
        return self
    }
    
    /// Sets a custom property on `URLSessionConfiguration` using a key path.
    ///
    /// - Parameters:
    ///   - keyPath: The writable key path to modify.
    ///   - value: The value to set.
    /// - Returns: A new `Configuration` instance with the updated setting.
    @discardableResult
    mutating func set<T>(_ keyPath: WritableKeyPath<URLSessionConfiguration, T>, to value: T) -> Self {
        configuration[keyPath: keyPath] = value
        return self
    }
    
    /// Builds and returns the configured `URLSessionConfiguration`.
    internal var build: URLSessionConfiguration {
        return configuration
    }
}
