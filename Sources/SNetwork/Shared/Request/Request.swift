//
//  RestRequestable.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

@available(iOS 12.0, macOS 10.14, tvOS 12.0, *)
public typealias Request = URLRequest

@available(iOS 12.0, macOS 10.14, tvOS 12.0, *)
extension Request {
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
    public func applying<T: Requestable>(_ requestable: T) -> Request {
        return requestable.apply(to: self)
    }
}
