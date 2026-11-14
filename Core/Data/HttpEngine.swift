import Foundation

public protocol HttpEngine {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
    func execute(_ request: URLRequest) async throws
}

nonisolated public struct Empty: Decodable, Sendable {
    public init() {}
}

public struct HttpEngineImpl: HttpEngine {
    public init() {}
    
    public func execute(_ request: URLRequest) async throws {
        let _: Empty = try await execute(request)
    }
    
    public func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        fatalError("Not implemented")
    }
}

public enum ApiError: Error {
    case noNetwork
    case decodingError
    case unknwon
}
