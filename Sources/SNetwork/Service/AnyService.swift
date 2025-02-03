//
//  AnyService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 03.02.25.
//

import Foundation

/// AnyService
/// A protocol defining a service that can send a request and receive a response asynchronously.
/// please also see: `send:`
public protocol AnyService: ~Copyable, Sendable {
    /// The type of the request associated with the service.
    associatedtype Request
    
    /// The type of the response the service will return.
    /// It must conform to `Sendable`.
    associatedtype Response: Sendable
    
    /// The request associated with the service.
    var request: Request { get }
    
    /// Sends the request and returns a response asynchronously.
    ///
    /// - Returns: A `Response` from the service after processing the request.
    /// - Throws: An error if the request could not be processed.
    func send() async throws -> Response
}

public extension AnyService {
    
    /// Sends the request and returns a response wrapped in a `Task`.
    ///
    /// This method initiates a detached asynchronous task that performs the `send` operation
    /// and returns a `Task` object that can be awaited for the result.
    ///
    /// - Returns: A `Task<Response, Error>` representing the asynchronous operation.
    func send() -> Task<Response, Error> {
        Task.detached {
            try await self.send()
        }
    }
    
    /// Sends the request and returns a response wrapped in a `Result`.
    ///
    /// This method synchronously waits for the asynchronous `send` operation to complete using a semaphore.
    /// It returns a `Result` containing either the `Response` or an error.
    ///
    /// - Returns: A `Result<Response, Error>` containing the response or error.
    func send() -> Result<Response, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Response, Error>!
        
        Task {
            do {
                let response = try await self.send()
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
