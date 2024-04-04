import Foundation

public protocol HttpInterceptable {
    func canHandle(_ request: URLRequest) -> Bool
    func handle<T: Decodable>(_ request: URLRequest) async throws -> T
}

public class HttpEngineMock: HttpEngine {
    private let real: HttpEngine
    private let simulatedDelay: TimeInterval
    private var interceptors = [HttpInterceptable]()
    
    public init(real: HttpEngine = HttpEngineImpl(), simulatedDelay: TimeInterval = 1.5) {
        self.real = real
        self.simulatedDelay = simulatedDelay
    }
    
    public func register(_ interceptor: HttpInterceptable) -> HttpEngineMock {
        interceptors.append(interceptor)
        return self
    }
    
    public func execute(_ request: URLRequest) async throws {
        _ = try await execute<Empty>(request)
    }
    
    public func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        try await Task.sleep(nanoseconds: UInt64(simulatedDelay) * 1_000_000)
        
        if let interceptor = interceptors.first(where: { $0.canHandle(request) }) {
            return try await interceptor.handle(request)
        } else {
            return try await real.execute(request)
        }
    }
}

extension HttpEngine {
    // TODO: fix error: static member 'mock' cannot be used on protocol metatype '(any HttpEngine).Type'
//    public static func mock() -> HttpEngine {
//        HttpEngineMock(real: HttpEngineImpl())
//    }
    
    public func mock() -> HttpEngine {
        HttpEngineMock(real: self)
    }
}
