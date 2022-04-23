public typealias HTTPHeader = [String: String]

public extension HTTPHeader: Requestable {
    func set(_ request: Request) -> Request {
        request.allHTTPHeaderFields = self
        return request
    }
}
