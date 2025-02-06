//
//  ConfigurationType.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

/// Enum that defines different types of session configurations.
///
/// This enumeration represents various configurations that can be used to create a `URLSessionConfiguration` for networking tasks. It includes three cases:
/// - `.default`: The default configuration used for most networking tasks.
/// - `.ephemeral`: A configuration that does not store cached data or credentials.
/// - `.background`: A background configuration, requiring a unique identifier to manage background tasks.
///
/// The `ConfigurationType` enum is available on iOS 12.0+, macOS 10.14+, tvOS 12.0+, and watchOS 5.0+.
///
/// - Note: The enum is `frozen`, meaning it cannot be subclassed or extended by other types.
///
/// ### Usage Example:
/// ```swift
/// let configType: ConfigurationType = .background("com.example.myapp")
/// let config = configType.makeConfiguration()
/// ```
@frozen
@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public enum ConfigurationType: Equatable, Sendable {
    
    /// The default configuration.
    /// Typically used for most network requests, it uses the default settings provided by `URLSession`.
    case `default`
    
    /// A configuration that creates a non-persistent session.
    /// No cached data or credentials are stored with this configuration.
    case ephemeral
    
    /// A configuration for background tasks.
    ///
    /// Requires a unique identifier to distinguish between background tasks.
    /// Use this for long-running tasks that can continue even when the app is suspended.
    case background(String)
    
    /// Converts the `ConfigurationType` to a `URLSessionConfiguration`.
    ///
    /// This method returns a corresponding `URLSessionConfiguration` based on the type of configuration:
    /// - `.default`: Returns the default session configuration.
    /// - `.ephemeral`: Returns an ephemeral session configuration.
    /// - `.background(identifier)`: Returns a background session configuration with the specified identifier.
    ///
    /// - Returns: A `URLSessionConfiguration` that corresponds to the current `ConfigurationType`.
    internal func makeConfiguration() -> URLSessionConfiguration {
        switch self {
        case .default:
            return .default
        case .ephemeral:
            return .ephemeral
        case .background(let identifier):
            return URLSessionConfiguration.background(withIdentifier: identifier)
        }
    }
}
