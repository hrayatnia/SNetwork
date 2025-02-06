//
//  Misc.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//

import Foundation

public extension NSMutableURLRequest {
    var toUrlRequest: URLRequest {
        return self as URLRequest
    }
}


public extension String {
    
    
    func destination(_ baseURL: URL? = nil) -> Destination {
        guard let url = baseURL?.appendingPathComponent(self) else {
            preconditionFailure("Invalid URL String")
            
        }
        return NSMutableURLRequest(url: url)
    }
}
