import Foundation
import Core

protocol OnboardingApi {
    func login(username: String, password: String) async throws -> Bool
    func logout() async throws
}

/// @Singleton(OnboardingApi)
final class OnboardingApiImpl: OnboardingApi {
    
    enum ApiError: Error {
        case noNetwork
        case decodingError
        case unknwon
    }
    
    init(httpEngine: HttpEngine, config: ApiConfig) {
        self.httpEngine = httpEngine
        self.authStore = config.authStore
        self.baseUrl = config.baseUrl
    }
    
    private let httpEngine: HttpEngine
    private let authStore: AuthenticationStore
    private let baseUrl: String
    
    func login(username: String, password: String) async throws -> Bool {
        let response: LoginResponse = try await HttpRequestBuilder(url: baseUrl)
            .path("login")
            .httpMethod(.post)
            .body(LoginRequest(username: username, password: password))
            .execute(using: httpEngine)
        
        authStore.acccessToken = response.accessToken
        
        return true
    }
    
    func logout() async throws {
        try await HttpRequestBuilder(url: baseUrl)
            .path("logout")
            .httpMethod(.post)
            .authenticate(using: authStore)
            .execute(using: httpEngine)
    }
}

// MARK: Models

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let accessToken: String
}
