import Foundation

/// @Singleton
public final class AuthenticationManager: ObservableObject {
    private let api: UserApi
    private let storage: Storage
    private let isLoggedInKey = "isLoggedInKey"
    
    @Published public private(set) var isLoggedIn: Bool
    
    public init(api: UserApi, storage: Storage) {
        self.api = api
        self.storage = storage
        
        isLoggedIn = (try? storage.value(for: isLoggedInKey)) ?? false
    }
    
    @MainActor public func login(username: String, password: String) async {
        // let result = await api.login()
        
        isLoggedIn = true
        
        updateStorage()
    }
    
    @MainActor public func logout() async {
        isLoggedIn = false
        
        updateStorage()
    }
    
    private func updateStorage() {
        try! storage.store(isLoggedIn, for: isLoggedInKey)
    }
}
