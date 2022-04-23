import Foundation

extension Data: Requestable {
    public func set(_ request: Request) -> Request {
        request.httpBody = self
        return request
    }
}
