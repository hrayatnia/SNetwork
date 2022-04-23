import Foundation

public typealias Request = NSMutableURLRequest

extension Request {
    public func set(_ request: Requestable) -> Request {
        request.set(self)
    }
}
