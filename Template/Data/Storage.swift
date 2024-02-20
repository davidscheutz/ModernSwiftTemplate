
protocol Storage {
    func store<T: Encodable>(_ value: T?, for key: AnyHashable) throws
    func value<T: Decodable>(for key: AnyHashable) throws -> T
    func removeValue(for key: AnyHashable)
}
