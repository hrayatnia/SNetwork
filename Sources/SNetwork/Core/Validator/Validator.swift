//
//  Validator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public protocol Validator: Sendable {
    associatedtype Input
    func validate(_ value: Input) throws
}

@available(iOS 13.0, macOS 13, tvOS 13.0, watchOS 6.0, *)
public extension Validator {
    func isValid(_ value: Input) -> Bool {
        do {
            try self.validate(value)
            return true
        } catch {
            return false
        }
    }
    
    func validate(_ value: Input) -> Result<Input, Error> {
        do {
            try self.validate(value)
            return .success(value)
        }catch(let error) {
            return .failure(error)
        }
    }
}
