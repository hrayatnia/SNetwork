import Foundation

extension Data: Requestable {
    func set(_ request: Request) -> Request {
        request.httpBody = self
        return request
    }
}