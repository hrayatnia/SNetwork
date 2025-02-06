//
//  RestNetworkHeader.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//


public struct RestNetworkHeader: NetworkHeader {
    public typealias Key = String
    
    public var headers: [Key: any Sendable & Hashable] = [
        RestHeaderKeyValue.contentType.key: RestHeaderKeyValue.contentType.rawValue,
        RestHeaderKeyValue.accept.key: RestHeaderKeyValue.contentType.rawValue
    ]
    
    @frozen
    private enum RestHeaderKeyValue: String {
        case contentType = "Application/JSON"
        case accept
        
        var key: String {
            return String(describing: self) // Convert case name to string
        }
    }
}
