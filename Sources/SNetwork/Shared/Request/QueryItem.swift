//
//  QueryItem.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

public typealias QueryItem = URLQueryItem

extension QueryItem: Requestable {
    
    /// Adds the query item to the request's URL components.
    ///
    /// This method appends the `QueryItem` (which represents a single key-value pair in the query string)
    /// to the `Request`'s URL. It first checks if the `Request` has a valid URL and URL components.
    /// If the URL components exist, the query item is added to the list of query items; otherwise,
    /// the original request is returned unchanged.
    ///
    /// - Parameter request: The `Request` to which the query item will be appended.
    /// - Returns: A new `Request` with the updated URL containing the added query item.
    ///
    /// - Example:
    /// ```swift
    /// let request = URLRequest(url: URL(string: "https://api.example.com")!)
    /// let queryItem = URLQueryItem(name: "page", value: "1")
    /// let modifiedRequest = queryItem.apply(to: request)
    /// // The modifiedRequest's URL will be "https://api.example.com?page=1"
    /// ```
    public func apply(to request: Request) -> Request {
        guard var urlComponents = URLComponents(url: request.url ?? URL(string: "")!, resolvingAgainstBaseURL: false) else {
            return request // Return the original request if URLComponents can't be created
        }
        
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(self)
        urlComponents.queryItems = queryItems
        
        var modifiedRequest = request
        modifiedRequest.url = urlComponents.url
        return modifiedRequest
    }
}
