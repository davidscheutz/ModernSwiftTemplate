import Foundation

public struct ApiConfig {
    public let baseUrl: String
    public let authStore: AuthenticationStore
    
    public init(baseUrl: String, authStore: AuthenticationStore) {
        self.baseUrl = baseUrl
        self.authStore = authStore
    }
}
