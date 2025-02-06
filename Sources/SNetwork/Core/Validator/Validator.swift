//
//  Validator.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

protocol Validator: Sendable {
    associatedtype Input
    func validate(_ value: Input) throws
}

extension Validator {
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
