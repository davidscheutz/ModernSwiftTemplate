import Foundation
import KeychainSwift

extension KeychainSwift: Storage {
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    public func store<T: Encodable>(_ value: T?, for key: AnyHashable) throws {
        if let value {
            let data = try Self.encoder.encode(value)
            self.set(data, forKey: keyString(from: key))
        } else {
            removeValue(for: key)
        }
    }
    
    public func value<T: Decodable>(for key: AnyHashable) throws -> T {
        guard let data = getData(keyString(from: key)) else {
            throw NSError(domain: "Data missing for key: \(key)", code: 0)
        }
        return try Self.decoder.decode(T.self, from: data)
    }
    
    public func removeValue(for key: AnyHashable) {
        delete(keyString(from: key))
    }
    
    private func keyString(from key: AnyHashable) -> String {
        "\(key)"
    }
}
