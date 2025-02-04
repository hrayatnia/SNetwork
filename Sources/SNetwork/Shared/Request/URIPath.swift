//
//  URIPath.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public typealias URIPath = String

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
extension URIPath: Requestable {
    
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
    public func apply(to request: Request) -> Request {
        guard var url = request.url else { return request }
        url.appendPathComponent(self)
        
        var modifiedRequest = request
        modifiedRequest.url = url
        return modifiedRequest
    }
}
