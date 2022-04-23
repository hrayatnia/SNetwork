public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case UPDATE = "UPDATE"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

extension HTTPMethod: Requestable {
    public func set(_ request: Request) -> Request {
        request.httpMethod = self.rawValue
        return request
    }
}
