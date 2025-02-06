//
//  RestValidator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//


protocol RestValidator: Validator {
    var isRequest: Bool { get }
}
