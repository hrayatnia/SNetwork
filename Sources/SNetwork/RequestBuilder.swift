import Foundation

public protocol Requestable {
    @discardableResult
    func set(_ request: Request) -> Request
}


@propertyWrapper
public struct RequestBuilder {
    public var requestable: [Requestable]
    public var wrappedValue: Request

    public init(requestable: [Requestable], wrappedValue: Request) {
        self.requestable = requestable
        self.wrappedValue = wrappedValue
        self.wrappedValue = bind(self.wrappedValue)
    }
    
    private func bind(_ request: Request) -> Request {
        var request = request
        for item in requestable {
            request = item.set(request)
        }
        return request
    }
}


public func requestableArray(@ArrayBuilder<Requestable> block: () -> [Requestable]) -> [Requestable] { block() }
