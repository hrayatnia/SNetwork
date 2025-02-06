//
//  RestNetworkHeader.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//


@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public struct RestNetworkHeader: NetworkHeader {
    public typealias Key = String
    
    public var headers: [Key: any Sendable & Hashable] = [
        RestHeaderKeyValue.contentType.key: RestHeaderKeyValue.contentType.rawValue,
        RestHeaderKeyValue.accept.key: RestHeaderKeyValue.contentType.rawValue
    ]
    
    public init(headers: [Key : any Sendable & Hashable]) {
        self.headers = headers
    }
    
    public init() {}
    
    @frozen
    private enum RestHeaderKeyValue: String {
        case contentType = "Application/JSON"
        case accept
        
        var key: String {
            return String(describing: self) // Convert case name to string
        }
    }
}
