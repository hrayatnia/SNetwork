//
//  RestGlobalSettings 2.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//
import Foundation

public struct RestSettings<DecoderType: Sendable>: Settings, Sendable {
    
    var baseURL: URL
    var configuration: Configuration
    var headers: any NetworkHeader
    var decoder: DecoderType
    var validator: [any Validator]
    
    init(baseURL: URL,
         decoder: DecoderType,
         validator: [any RestValidator] = [RestStatusCodeValidator(),
                                           RestURLRequestValidator()],
         configuration: Configuration = NetworkConfiguration(),
         headers: any NetworkHeader = RestNetworkHeader()) {
        self.baseURL = baseURL
        self.configuration = configuration
        self.headers = headers
        self.decoder = decoder
        self.validator = validator
    }
    
    init(baseURL: URL) where DecoderType == JSONDecoder {
        self.init(baseURL: baseURL, decoder: JSONDecoder())
        self.decoder = _jsonDecoder
    }
    
    
    private var _jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if #available(macOS 12.0, *) {
            decoder.allowsJSON5 = true
        } else {
        }
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    private var _networkHeader: some NetworkHeader {
        RestNetworkHeader()
    }
    
}

