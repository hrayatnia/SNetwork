public protocol NetworkAdapter {
    func run<Response: Decodable, ServiceError: Error>(request: Request,
             response: @escaping (Result<Response, ServiceError>)->())
}
