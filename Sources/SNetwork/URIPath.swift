//
//  File.swift
//  
//
//  Created by Sam Ray on 2022-04-23.
//

import Foundation

public typealias URIPath = String

extension URIPath: Requestable {
    public func set(_ request: Request) -> Request {
        request.url?.appendPathComponent(self)
        return request
    }
}
