import Core
import Foundation
import SwiftEvolution

// TODO: simplify singleton type registration
/// @Singleton(AuthenticationManager)

/// @Singleton(types: [AuthenticationManager, AuthenticationManagerImpl])
public final class AuthenticationManagerImpl: AuthenticationManager, ObservableObject {
    private let api: OnboardingApi
    private let storage: Storage
    private let isLoggedInKey = "isLoggedInKey"
    
    @Published public private(set) var isLoggedIn: Bool
    
    init(api: OnboardingApi, storage: Storage) {
        self.api = api
        self.storage = storage
        
        isLoggedIn = (try? storage.value(for: isLoggedInKey)) ?? false
    }
    
    @MainActor public func login(username: String, password: String) async throws {
        isLoggedIn = try await api.login(username: username, password: password)
        
        updateStorage()
    }
    
    @MainActor public func logout() async {
        Task { try await api.logout() }
        
        isLoggedIn = false
        
        updateStorage()
    }
    
    private func updateStorage() {
        try! storage.store(isLoggedIn, for: isLoggedInKey)
    }
}
