//
//  RestRequestable.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public typealias Destination = NSMutableURLRequest

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
extension Destination: @unchecked @retroactive Sendable {
    /// Mutates a request by adding data to it.
    ///
    /// This method allows the modification of a `Request` by applying an object that conforms to the `Requestable` protocol.
    /// The provided `Requestable` object will apply its transformation to the request, allowing for changes such as setting
    /// the HTTP body, headers, or other properties.
    ///
    /// - Parameter requestable: An object conforming to `Requestable` that will modify the request's properties.
    /// - Returns: A new `Request` with the modified properties based on the provided `Requestable` object.
    ///
    /// - Example:
    /// ```swift
    /// let request = URLRequest(url: URL(string: "https://api.example.com")!)
    /// let data = Data() // some data to apply
    /// let modifiedRequest = request.applying(data)
    /// // The modifiedRequest will have the data as its HTTP body
    /// ```
    @discardableResult
    public func applying<T: Addressable>(_ requestable: T) -> Destination {
        return requestable.apply(to: self)
    }
    
    
    internal var asURLRequest: URLRequest {
        return self as URLRequest
    }
}
