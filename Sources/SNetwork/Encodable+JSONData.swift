import Foundation

public extension Encodable {
    func data() -> Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(self)
    }
}
