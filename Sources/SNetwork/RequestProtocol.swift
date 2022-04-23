import Foundation

typealias Request = NSMutableURLRequest

extension Request {
    func set(_ request: Requestable) -> Request {
        request.set(self)
    }
}
