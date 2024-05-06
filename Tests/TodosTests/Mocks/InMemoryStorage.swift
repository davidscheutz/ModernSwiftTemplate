import Foundation
import Core

class InMemoryStorage: Storage {
    
    private var data: [AnyHashable: Data] = [:]
    
    func store<T>(_ value: T?, for key: AnyHashable) throws where T : Encodable {
        if let value {
            data[key] = try JSONEncoder().encode(value)
        } else {
            removeValue(for: key)
        }
    }
    
    func value<T>(for key: AnyHashable) throws -> T where T : Decodable {
        if let data = data[key] {
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            throw NSError(domain: "No value found for key \(key)", code: 0)
        }
    }
    
    func removeValue(for key: AnyHashable) {
        data.removeValue(forKey: key)
    }
}
