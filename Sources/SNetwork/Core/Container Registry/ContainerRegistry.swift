//
//  ContainerRegistry.swift
//  SNetwork
//
//  Created by Sam Rayatnia on 06.02.25.
//

protocol ContainerRegistry {
    associatedtype StoredType
    static var shared: Self { get }
    var container: [String: StoredType] { get }
    mutating func register<T>(_ type: T.Type, _ value: StoredType)
}

extension ContainerRegistry {
    func resolve<T>(_ type: T.Type) -> (StoredType)? {
        return container[String(describing: type)]
    }
}
