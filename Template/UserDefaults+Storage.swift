import Foundation
import Core

extension UserDefaults: Storage {
    public func store<T>(_ value: T?, for key: AnyHashable) throws where T : Encodable {
        guard let value else {
            removeValue(for: key)
            return
        }
        let data = try JSONEncoder().encode(value)
        set(data, forKey: key.description)
    }
    
    public func value<T>(for key: AnyHashable) throws -> T where T : Decodable {
        guard let data = data(forKey: key.description) else {
            throw NSError(domain: "Value not found for key: \(key)", code: 404)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    public func removeValue(for key: AnyHashable) {
        removeObject(forKey: key.description)
    }
}
