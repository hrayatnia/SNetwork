import Foundation

@resultBuilder
public struct ArrayBuilder<T> {

    public static func buildBlock() -> [T] { [] }
    public static func buildBlock(_ expression: T) -> [T] { [expression] }
    public static func buildBlock(_ elements: T...) -> [T] { elements }
    public static func buildBlock(_ elementss: [T]...) -> [T] { elementss.flatMap({ $0 }) }
    public static func buildBlock(_ elements: [T]) -> [T] { elements }
    public static func buildEither(first: [T]) -> [T] { first }
    public static func buildEither(second: [T]) -> [T] { second }
    public static func buildIf(_ element: [T]?) -> [T] { element ?? [] }
    public static func buildBlock(_ element: Never) -> [T] {}
    public static func buildBlock(_ array1: [T], _ trailing: T...) -> [T] { array1 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ trailing: T...) -> [T] { [e1] + array1 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ array1: [T], _ trailing: T...) -> [T] { [e1, e2] + array1 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ e3: T, _ array1: [T], _ trailing: T...) -> [T] { [e1, e2, e3] + array1 + trailing }

    public static func buildBlock(_ array1: [T], _ array2: [T], _ e1: T, _ trailing: T...) -> [T] { array1 + array2 + [e1] + trailing }
    public static func buildBlock(_ array1: [T], _ e1: T, _ array2: [T], _ trailing: T...) -> [T] { array1 + [e1] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ array2: [T], _ trailing: T...) -> [T] { [e1] + array1 + array2 + trailing }
    
    public static func buildBlock(_ array1: [T], _ e1: T, _ e2: T, _ array2: [T], _ trailing: T...) -> [T] { array1 + [e1, e2] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ e2: T, _ array2: [T], _ trailing: T...) -> [T] { [e1] + array1 + [e2] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ array1: [T], _ array2: [T], _ trailing: T...) -> [T] { [e1, e2] + array1 + array2 + trailing }
    
    public static func buildBlock(_ array1: [T], _ e1: T, _ e2: T, _ e3: T, _ array2: [T], _ trailing: T...) -> [T] { array1 + [e1, e2, e3] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ array1: [T], _ e2: T, _ e3: T, _ array2: [T], _ trailing: T...) -> [T] { [e1] + array1 + [e2, e3] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ array1: [T], _ e3: T, _ array2: [T], _ trailing: T...) -> [T] { [e1, e2] + array1 + [e3] + array2 + trailing }
    public static func buildBlock(_ e1: T, _ e2: T, _ e3: T, _ array1: [T], _ array2: [T], _ trailing: T...) -> [T] { [e1, e2, e3] + array1 + array2 + trailing }
    
}
