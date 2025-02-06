//
//  Encodable+JSONData.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 04.02.25.
//

import Foundation

public extension Encodable {
    /// Encodes the object into `Data` using the provided encoder.
    ///
    /// This method attempts to encode the conforming `Encodable` object into a `Data` representation
    /// using a specified `JSONEncoder`. If encoding is successful, it returns the encoded `Data`.
    /// If an error occurs during encoding, it returns an error in a `Result` type.
    ///
    /// - Parameter encoder: The `JSONEncoder` to use for encoding. Defaults to `JSONEncoder()`.
    /// - Returns: A `Result` containing either the encoded `Data` or an error.
    ///
    /// - Example:
    /// ```swift
    /// let encoder = JSONEncoder()
    /// let result = myObject.encoded(using: encoder)
    /// switch result {
    /// case .success(let data):
    ///     // Handle the encoded data
    /// case .failure(let error):
    ///     // Handle the error
    /// }
    /// ```
    func encoded(using encoder: JSONEncoder = JSONEncoder()) -> Result<Data, Error> {
        do {
            let data = try encoder.encode(self)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    /// Encodes the object into `Data` and returns the result or throws an error.
    ///
    /// This method calls the `encoded(using:)` method and returns the encoded `Data` directly.
    /// If the encoding fails, it throws an error.
    ///
    /// - Parameter encoder: The `JSONEncoder` to use for encoding. Defaults to `JSONEncoder()`.
    /// - Returns: The encoded `Data`.
    ///
    /// - Throws: Any error that occurs during encoding.
    ///
    /// - Example:
    /// ```swift
    /// do {
    ///     let data = try myObject.encoded(using: encoder)
    ///     // Use the encoded data
    /// } catch {
    ///     // Handle the error
    /// }
    /// ```
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoded(using: encoder).get()
    }
}
