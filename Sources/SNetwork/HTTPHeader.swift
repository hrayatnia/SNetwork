typealias HTTPHeader = [String: String]

extension HTTPHeader: Requestable {
    func set(_ request: Request) -> Request {
        request.allHTTPHeaderFields = self
        return request
    }
}
