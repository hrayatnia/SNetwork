//
//  AnyService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 03.02.25.
//

import Foundation

/// `AnyService`
///
/// A generic protocol that defines a service capable of sending a request and receiving a response asynchronously.
///
/// Implementing types should specify the `Request` and `Response` associated types, where `Response` must conform to `Sendable`.
///
/// - Note: This protocol supports both async/await and alternative synchronous access patterns.
/// - SeeAlso: `send()`
@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol AnyService: ~Copyable, Sendable {
    /// The type of the request associated with the service.
    associatedtype Request
    
    /// The type of the response the service will return.
    ///
    /// Conforming types must ensure that `Response` adheres to `Sendable`.
    associatedtype Response: Sendable
    
    /// The destination type associated with the service.
    associatedtype Destination
    
    /// The request instance associated with the service.
    var request: Request { get }
    
    /// The destination associated with the service.
    var destination: Destination { get }
    
    /// Sends the request asynchronously and returns a response.
    ///
    /// - Returns: A `Response` instance upon successful processing of the request.
    /// - Throws: An error if the request cannot be processed.
    func send() async throws -> Response
   
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public extension AnyService {
    
    
    /// Sends the request asynchronously and returns a response wrapped in a `Task`.
    ///
    /// This method creates a detached task that executes the `send` operation.
    /// The returned `Task` can be awaited to retrieve the response.
    ///
    /// - Returns: A `Task<Response, Error>` representing the asynchronous operation.
    func send() -> Task<Response, Error> {
        Task.detached {
            try await self.send()
        }
    }
    
    /// Sends the request and returns a response wrapped in a `Result`.
    ///
    /// This method executes the `send` operation synchronously by leveraging a semaphore.
    /// The result is returned as a `Result<Response, Error>`, containing either a valid response or an error.
    ///
    /// - Warning: Blocking execution with a semaphore can introduce performance bottlenecks. Use with caution.
    /// - Returns: A `Result<Response, Error>` containing the response or an error.
    func send() -> Result<Response, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Response, Error>!
        
        Task {
            do {
                let response: Response = try await self.send()
                result = .success(response)
            } catch {
                result = .failure(error)
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
