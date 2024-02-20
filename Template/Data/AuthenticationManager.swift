import Foundation

/// @Singleton
final class AuthenticationManager: ObservableObject {
    private let api: UserApi
    private let storage: Storage
    private let isLoggedInKey = "isLoggedInKey"
    
    @Published private(set) var isLoggedIn: Bool
    
    init(api: UserApi, storage: Storage) {
        self.api = api
        self.storage = storage
        
        isLoggedIn = (try? storage.value(for: isLoggedInKey)) ?? false
    }
    
    @MainActor func login(username: String, password: String) async {
        // let result = await api.login()
        
        try! storage.store(true, for: isLoggedInKey)
        
        isLoggedIn = true
    }
}
