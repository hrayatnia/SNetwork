//
//  URIPath.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public typealias URIPath = String

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
extension URIPath: Addressable {
    
    /// Appends the URI path component to the request's URL.
    ///
    /// This method appends the `URIPath` (a `String` representing a path) to the `Request`'s URL. If the URL
    /// exists in the request, it will modify the URL by appending the path component. If the URL is nil,
    /// the original request is returned unchanged.
    ///
    /// - Parameter request: The `Request` to which the URI path will be appended.
    /// - Returns: A new `Request` with the modified URL that includes the appended URI path component.
    ///
    /// - Example:
    /// ```swift
    /// let request = Request(url: URL(string: "https://api.example.com"))
    /// let uriPath: URIPath = "/users"
    /// let modifiedRequest = uriPath.apply(to: request)
    /// // The modifiedRequest's URL will be "https://api.example.com/users"
    /// ```
    public func apply(to request: Destination) -> Destination {
        guard var url = request.url else { return request }
        url.appendPathComponent(self)
        let modifiedRequest = request
        modifiedRequest.url = url
        return modifiedRequest
    }
}
