import Foundation

public typealias Request = NSMutableURLRequest

public extension Request {
    func set(_ request: Requestable) -> Request {
        request.set(self)
    }
}
