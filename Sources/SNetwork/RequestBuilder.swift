import Foundation

open protocol Requestable {
    @discardableResult
    func set(_ request: Request) -> Request
}


@propertyWrapper
public struct RequestBuilder {
    var requestable: [Requestable]
    var wrappedValue: Request? {
        didSet {
            guard let wrappedValue = wrappedValue else {
                return
            }
            self.wrappedValue = bind(wrappedValue)
        }
    }
    
    private func bind(_ request: Request) -> Request {
        var request = request
        for item in requestable {
            request = item.set(request)
        }
        return request
    }
}


public func requestableArray(@ArrayBuilder<String> block: () -> [String]) -> [String] { block() }
