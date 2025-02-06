//
//  NetworkHeader.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//


/// A protocol that represents a network header with dynamic key-value access.
/// It allows for the dynamic manipulation of headers, including adding, removing, and retrieving them.
/// This protocol is designed to be used with network request headers or any context where a dictionary of headers is required.
@dynamicMemberLookup
@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol NetworkHeader: ~Copyable, Sendable {

    /// The type used as the key for headers. This should conform to `StringProtocol`.
    associatedtype Key: StringProtocol & Sendable

    /// A dictionary that holds the headers as key-value pairs.
    /// The key is of type `Key` and the value is of type `AnyHashable`.
    var headers: [Key: any Sendable & Hashable] { get set }
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
extension NetworkHeader {

    /// Accessor for dynamically retrieving or setting header values using a key.
    ///
    /// This allows you to access or modify headers using dynamic member lookup syntax.
    ///
    /// - Parameter member: The key for the header.
    /// - Returns: The value associated with the key, if it exists, otherwise `nil`.
    subscript(dynamicMember member: Key) -> (any Hashable & Sendable)? {
        get {
            return headers[member]
        }
        set {
            headers[member] = newValue
        }
    }

    /// Adds or updates a custom header with the specified key and value.
    ///
    /// If a header with the same key already exists, it will be updated with the new value.
    ///
    /// - Parameter key: The key for the header to add or update.
    /// - Parameter value: The value to associate with the header key.
    mutating func addHeader(key: Key, value: any Hashable & Sendable) {
        headers[key] = value
    }

    /// Removes a header from the headers dictionary using the specified key.
    ///
    /// - Parameter key: The key of the header to be removed.
    mutating func removeHeader(key: Key) {
        headers.removeValue(forKey: key)
    }

    /// Returns all headers as a dictionary of type `[Key: AnyHashable]`.
    ///
    /// - Returns: A dictionary containing all the headers.
    func allHeaders() -> [Key: any Hashable & Sendable] {
        return headers
    }

    /// Checks whether a specific header exists in the headers dictionary.
    ///
    /// - Parameter key: The key of the header to check for.
    /// - Returns: `true` if the header exists, `false` otherwise.
    func containsHeader(key: Key) -> Bool {
        return headers.keys.contains(key)
    }

    /// Clears all headers from the headers dictionary.
    ///
    /// This will remove all key-value pairs from the headers.
    mutating func clearHeaders() {
        headers.removeAll()
    }
}
