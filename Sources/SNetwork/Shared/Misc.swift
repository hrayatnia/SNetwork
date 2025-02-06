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
    var asUrl: URL? {
        URL(string: self)
    }
    
    var destination: Destination {
        guard let asUrl else {
            preconditionFailure("Invalid URL String")
            
        }
        return NSMutableURLRequest(url: asUrl)
    }
}
