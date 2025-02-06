//
//  Misc.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Foundation

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public extension NSMutableURLRequest {
    var toUrlRequest: URLRequest {
        return self as URLRequest
    }
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public extension String {
    
    
    func destination(_ baseURL: URL? = nil) -> Destination {
        guard let url = baseURL?.appendingPathComponent(self) else {
            preconditionFailure("Invalid URL String")
            
        }
        return NSMutableURLRequest(url: url)
    }
}
