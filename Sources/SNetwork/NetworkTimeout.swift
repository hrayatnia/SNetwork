public enum NetworkTimeout: Double {
    case short = 15.0
    case `default` = 30.0
    case long = 60.0
}

extension NetworkTimeout: Requestable {
    public func set(_ request: Request) -> Request {
        request.timeoutInterval = self.rawValue
        return request
    }
}
