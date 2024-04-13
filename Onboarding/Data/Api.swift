import Foundation
import Core

protocol OnboardingApi {
    func login(username: String, password: String) async throws -> Bool
    func logout() async throws
}

/// @Singleton(types: [OnboardingApi])
final class OnboardingApiImpl: OnboardingApi {
    
    enum ApiError: Error {
        case noNetwork
        case decodingError
        case unknwon
    }
    
    init(httpEngine: HttpEngine) {
        self.httpEngine = httpEngine
    }
    
    // TODO: inject and resolve using key?
    private let baseUrl = "https://myserver.com/api/v1"
    private let httpEngine: HttpEngine
    
    func login(username: String, password: String) async throws -> Bool {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/login")!))
    }
    
    func logout() async throws {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/logout")!))
    }
}

public final class OnboardingApiMock: HttpInterceptable {
    public init() {}
    
    public func canHandle(_ request: URLRequest) -> Bool {
        guard let url = request.url?.absoluteString else { return false }
        return url.contains("login") || url.contains("logout")
    }
    
    public func handle<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        switch T.self {
        case is Bool.Type:
            if request.url?.absoluteString.contains("login") == true {
                return true as! T
            }
        case is Empty.Type:
            if request.url?.absoluteString.contains("login") == true {
                return Empty() as! T
            }
            
        default: break
        }
        
        throw NSError(domain: "No mock registered for type: \(T.self)", code: 404)
    }
}
