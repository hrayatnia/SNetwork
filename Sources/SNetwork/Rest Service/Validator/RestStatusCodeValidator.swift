//
//  RestStatusCodeValidator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public struct RestStatusCodeValidator: RestResponseValidator {
    public var isRequest: Bool = false
    
    public typealias Input = (Int, URL)

    public func validate(_ value: Input) throws {
        let (statusCode, url) = value
        guard let status = HTTPStatusCode(rawValue: statusCode) else {
            throw URLError(.badServerResponse)
        }
        do {
            try status.validate(url: url)
        } catch {
            throw error
        }
    }
}

// Combined Enum for both status codes and error handling
@frozen
@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public enum HTTPStatusCode: Int, CaseIterable {
    // Success cases
    case ok = 200, created = 201, accepted = 202, noContent = 204
    
    // Redirection
    case movedPermanently = 301, found = 302, seeOther = 303,
         temporaryRedirect = 307, permanentRedirect = 308
    
    // Client errors
    case badRequest = 400, unauthorized = 401, forbidden = 403,
         notFound = 404, requestTimeout = 408, tooManyRequests = 429
    
    // Server errors
    case internalServerError = 500, badGateway = 502,
         serviceUnavailable = 503, gatewayTimeout = 504
    
    
    func validate(url: URL) throws {
        switch self {
        case .ok, .created, .accepted, .noContent:
            return // Success, no error thrown
            
            // Handle redirection
        case .movedPermanently: throw HTTPStatusCodeError.movedPermanently(url)
        case .found: throw HTTPStatusCodeError.found(url)
        case .seeOther: throw HTTPStatusCodeError.seeOther(url)
        case .temporaryRedirect: throw HTTPStatusCodeError.temporaryRedirect(url)
        case .permanentRedirect: throw HTTPStatusCodeError.permanentRedirect(url)
            
            // Handle client errors
        case .badRequest: throw HTTPStatusCodeError.badRequest(url)
        case .unauthorized: throw HTTPStatusCodeError.unauthorized(url)
        case .forbidden: throw HTTPStatusCodeError.forbidden(url)
        case .notFound: throw HTTPStatusCodeError.notFound(url)
        case .requestTimeout: throw HTTPStatusCodeError.requestTimeout(url)
        case .tooManyRequests: throw HTTPStatusCodeError.tooManyRequests(url)
            
            // Handle server errors
        case .internalServerError: throw HTTPStatusCodeError.internalServerError(url)
        case .badGateway: throw HTTPStatusCodeError.badGateway(url)
        case .serviceUnavailable: throw HTTPStatusCodeError.serviceUnavailable(url)
        case .gatewayTimeout: throw HTTPStatusCodeError.gatewayTimeout(url)
        }
    }
}

// Combined Error Enum for LocalizedError
@frozen
@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public enum HTTPStatusCodeError: LocalizedError {
    // Redirection errors
    case movedPermanently(URL?)
    case found(URL?)
    case seeOther(URL?)
    case temporaryRedirect(URL?)
    case permanentRedirect(URL?)

    // Client errors
    case badRequest(URL?)
    case unauthorized(URL?)
    case forbidden(URL?)
    case notFound(URL?)
    case requestTimeout(URL?)
    case tooManyRequests(URL?)

    // Server errors
    case internalServerError(URL?)
    case badGateway(URL?)
    case serviceUnavailable(URL?)
    case gatewayTimeout(URL?)

    // Unknown error
    case unknown(Int, URL?)

    public var errorDescription: String {
        switch self {
        case .movedPermanently(let url): return "The requested resource at \(url?.absoluteString ?? "unknown URL") has moved permanently."
        case .found(let url): return "The requested resource at \(url?.absoluteString ?? "unknown URL") was found elsewhere."
        case .seeOther(let url): return "See another resource instead of \(url?.absoluteString ?? "unknown URL")."
        case .temporaryRedirect(let url): return "The resource at \(url?.absoluteString ?? "unknown URL") is temporarily redirected."
        case .permanentRedirect(let url): return "The resource at \(url?.absoluteString ?? "unknown URL") has been permanently redirected."

        case .badRequest(let url): return "Bad request sent to \(url?.absoluteString ?? "unknown URL")."
        case .unauthorized(let url): return "Unauthorized access to \(url?.absoluteString ?? "unknown URL")."
        case .forbidden(let url): return "Access to \(url?.absoluteString ?? "unknown URL") is forbidden."
        case .notFound(let url): return "The requested resource at \(url?.absoluteString ?? "unknown URL") was not found."
        case .requestTimeout(let url): return "The request to \(url?.absoluteString ?? "unknown URL") timed out."
        case .tooManyRequests(let url): return "Too many requests sent to \(url?.absoluteString ?? "unknown URL"). Please slow down."

        case .internalServerError(let url): return "Internal server error at \(url?.absoluteString ?? "unknown URL")."
        case .badGateway(let url): return "Bad gateway error while accessing \(url?.absoluteString ?? "unknown URL")."
        case .serviceUnavailable(let url): return "Service unavailable at \(url?.absoluteString ?? "unknown URL")."
        case .gatewayTimeout(let url): return "Gateway timeout while accessing \(url?.absoluteString ?? "unknown URL")."

        case .unknown(let statusCode, let url): return "Unknown HTTP status code \(statusCode) for \(url?.absoluteString ?? "unknown URL")."
        }
    }
}

