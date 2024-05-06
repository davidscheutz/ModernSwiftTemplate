import Foundation

public protocol HttpInterceptable {
    func canHandle(_ request: URLRequest) -> Bool
    func handle<T: Decodable>(_ request: URLRequest) async throws -> T
}

public class HttpEngineMock: HttpEngine {
    private let real: HttpEngine
    private let simulateDelay: Bool
    private var interceptors = [HttpInterceptable]()
    
    public init(simulateDelay: Bool = true, real: HttpEngine = HttpEngineImpl()) {
        self.real = real
        self.simulateDelay = simulateDelay
    }
    
    public func register(_ interceptor: HttpInterceptable) -> HttpEngineMock {
        interceptors.append(interceptor)
        return self
    }
    
    public func execute(_ request: URLRequest) async throws {
        let _: Empty = try await execute(request)
    }
    
    public func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        if simulateDelay {
            try await Task.sleep(nanoseconds: UInt64(Double.random(in: 0.3...1.2) * 1_000_000_000))
        }
        
        if let interceptor = interceptors.first(where: { $0.canHandle(request) }) {
            return try await interceptor.handle(request)
        } else {
            return try await real.execute(request)
        }
    }
}
