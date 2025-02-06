//
//  Requestable 2.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

@available(iOS 12.0, macOS 10.14, tvOS 12.0, *)
public protocol Addressable {
    /// Applies a transformation to a request.
    ///
    /// This method defines the required behavior for types that modify or transform a `Request`.
    /// Implementing types must provide their own transformation logic that applies changes to a request
    /// (e.g., modifying the body, URL, headers, etc.) and return a new modified request.
    ///
    /// - Parameter request: The original request to modify.
    /// - Returns: The transformed `Request` with the applied changes.
    ///
    /// - Example:
    /// ```swift
    /// let modifiedRequest = someRequestableObject.apply(to: originalRequest)
    /// ```
    func apply(to request: Destination) -> Destination
}

@available(iOS 12.0, macOS 10.14, tvOS 12.0, *)
extension Data: Addressable {
    /// Appends the data as the HTTP body to the request.
    ///
    /// This method adds the `Data` as the HTTP body of the provided `Request` object.
    /// If the original request does not have an HTTP body, this will set the body for the first time.
    /// The method returns a new `Request` that includes the modified body.
    ///
    /// - Parameter request: The original request to modify.
    /// - Returns: A new `Request` with the data applied as the HTTP body.
    ///
    /// - Example:
    /// ```swift
    /// let data = Data() // some data
    /// let modifiedRequest = data.apply(to: originalRequest)
    /// // The modifiedRequest will have the data as its HTTP body
    /// ```
    public func apply(to request: Destination) -> Destination {
        var modifiedRequest = request
        modifiedRequest.httpBody = self
        return modifiedRequest
    }
}
