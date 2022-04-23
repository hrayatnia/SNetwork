public typealias HTTPHeader = [String: String]

extension HTTPHeader: Requestable {
    public func set(_ request: Request) -> Request {
        request.allHTTPHeaderFields = self
        return request
    }
}
