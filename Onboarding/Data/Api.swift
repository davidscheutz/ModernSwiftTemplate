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
