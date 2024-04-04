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
    
    private let baseUrl = "https://myserver.com/api/v1"
    private let httpEngine: HttpEngine
    
    // MARK: - UserApi
    
    public func login(username: String, password: String) async throws -> Bool {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/login")!))
    }
    
    public func logout() async throws {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/logout")!))
    }
}
