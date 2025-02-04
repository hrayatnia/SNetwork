//
//  HTTPMethod.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

@frozen

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
public enum HTTPMethod: String {
    /// The HTTP GET method.
    case GET = "GET"
    
    /// The HTTP POST method.
    case POST = "POST"
    
    /// The HTTP PUT method.
    case PUT = "PUT"
    
    /// The HTTP UPDATE method.
    case UPDATE = "UPDATE"
    
    /// The HTTP DELETE method.
    case DELETE = "DELETE"
    
    /// The HTTP PATCH method.
    case PATCH = "PATCH"
}

@available(iOS 12.0, macOS 10.14, tvOS 12.0, watchOS 5.0, *)
extension HTTPMethod: Requestable {
    /// Sets the HTTP method for the request.
    ///
    /// This method applies the HTTP method (e.g., GET, POST, PUT, etc.) to the provided `Request` by setting its `httpMethod` property.
    /// The `HTTPMethod` enum provides standard HTTP methods as raw strings that are assigned to the `httpMethod` field in the request.
    ///
    /// - Parameter request: The original `Request` to modify.
    /// - Returns: A new `Request` with the modified HTTP method.
    ///
    /// - Example:
    /// ```swift
    /// let request = URLRequest(url: URL(string: "https://api.example.com")!)
    /// let method: HTTPMethod = .POST
    /// let modifiedRequest = method.apply(to: request)
    /// // The modifiedRequest will have its HTTP method set to "POST"
    /// ```
    public func apply(to request: Request) -> Request {
        var modifiedRequest = request
        modifiedRequest.httpMethod = self.rawValue
        return request
    }
}


#if DEBUG
extension HTTPMethod: CaseIterable {
    
}
#endif
