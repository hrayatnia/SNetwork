public protocol NetworkAdapter {
    func run<Response: Decodable>(request: Request,
             response: @escaping (Result<Response, Error>)->())
}
