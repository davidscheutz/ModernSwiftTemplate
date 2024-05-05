import Foundation
import Core

/// @Singleton
final class RootCoordinator: ObservableObject {
    
    enum State {
        case loggedIn
        case loggedOut
        
        static func from(isLoggedIn: Bool) -> Self {
            isLoggedIn ? .loggedIn : .loggedOut
        }
    }
    
    @Published private(set) var state: State
    
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
        self.state = .from(isLoggedIn: authenticationManager.isLoggedIn.value)
        
        subscribeToAuthChanges()
    }
    
    private func subscribeToAuthChanges() {
        authenticationManager.isLoggedIn
            .receiveOnMain()
            .map { .from(isLoggedIn: $0) }
            .assign(to: &$state)
    }
}
