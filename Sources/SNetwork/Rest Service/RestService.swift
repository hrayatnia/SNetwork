//
//  RestService.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 05.02.25.
//


@available(iOS 12.0, macOS 10.14, tvOS 12.0, *)
public protocol RestService: ~Copyable,
                              AnyService where Response: Decodable {
}
