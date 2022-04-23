public protocol AnyService: AnyObject {
    associatedtype Response: Decodable
    var network: NetworkAdapter { get }
    var request: Request { get }
    var result: Result<Response, Error>? { get set }
}

extension AnyService {
    public func run() {
        network.run(request: request) { [weak self] result in
            self?.result = result
        }
    }
}
