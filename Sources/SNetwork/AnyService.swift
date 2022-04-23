public protocol AnyService: AnyObject {
    associatedtype Response: Decodable
    associatedtype ServiceError: Error
    var network: NetworkAdapter { get }
    var request: Request { get }
    var result: Result<Response, ServiceError> { get set }
}

extension AnyService {
    public func run() {
        network.run(request: request) { [weak self] result in
            self?.result = result
        }
    }
}
