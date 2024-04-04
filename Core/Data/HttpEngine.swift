import Foundation

public protocol HttpEngine {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
    func execute(_ request: URLRequest) async throws
}

private struct Empty: Decodable {}

public struct HttpEngineImpl: HttpEngine {
    public init() {}
    
    public func execute(_ request: URLRequest) async throws {
        _ = try await execute<Empty>(request)
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
