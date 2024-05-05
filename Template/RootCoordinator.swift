import Foundation
import Core

/// Used to coordinate the transition between independent features.
/// In this example the 'Onboarding' and 'Todos' framework both
/// handle their navigation stack. The handover in this case is triggered
/// using the observable authentication boolean. Another example
/// would be the usage of completions, where one feature's work is
/// completed and another feature takes over.

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
