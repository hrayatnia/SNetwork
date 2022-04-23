public enum NetworkTimeout: Double {
    case short = 15.0
    case `default` = 30.0
    case long = 60.0
}

public extension NetworkTimeout: Requestable {
    
    func set(_ request: Request) -> Request {
        request.timeoutInterval = self.rawValue
        return request
    }
}
