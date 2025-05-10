import Core
import Combine
import SwiftEvolution
import SwiftDependencyContainer

@Singleton(AuthenticationManager.self)
public final class AuthenticationManagerImpl: AuthenticationManager {
    private let api: OnboardingApi
    private let storage: LocalStorage
    private let isLoggedInKey = "isLoggedInKey"
    
    public private(set) lazy var isLoggedIn = CurrentValuePublisher(_isLoggedIn)
    private let _isLoggedIn: CurrentValueSubject<Bool, Never>
    private var storageUpdateListener: AnyCancellable?
    
    init(api: OnboardingApi, storage: LocalStorage) {
        self.api = api
        self.storage = storage
        
        _isLoggedIn = .init((try? storage.value(for: isLoggedInKey)) ?? false)
        
        persistStateChanges()
    }
    
    public func login(username: String, password: String) async throws {
        _isLoggedIn.value = try await api.login(username: username, password: password)
    }
    
    public func logout() async {
        Task { try await api.logout() }
        
        _isLoggedIn.value = false
    }
    
    private func persistStateChanges() {
        storageUpdateListener = _isLoggedIn.dropFirst().removeDuplicates().sink {
            try! self.storage.store($0, for: self.isLoggedInKey)
        }
    }
}
