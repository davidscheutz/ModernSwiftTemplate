import Foundation
import Core
import SwiftDependencyContainer

/// Used to coordinate the transition between independent features.
/// In this demo project the 'Onboarding' and 'Todos' framework both
/// handle their navigation stack. The decision which framework is
/// currently active is derived from the observable authentication state.

@Singleton
final class RootCoordinator: ObservableObject {
    
    enum AppState {
        case loggedIn
        case loggedOut
        
        static func from(isLoggedIn: Bool) -> Self {
            isLoggedIn ? .loggedIn : .loggedOut
        }
    }
    
    @Published private(set) var appState: AppState
    
    init(authenticationManager: AuthenticationManager) {
        appState = .from(isLoggedIn: authenticationManager.isLoggedIn.value)
        
        subscribeToAuthChanges(authenticationManager)
    }
    
    private func subscribeToAuthChanges(_ authenticationManager: AuthenticationManager) {
        authenticationManager.isLoggedIn
            .map { .from(isLoggedIn: $0) }
            .receiveOnMain()
            .assign(to: &$appState)
    }
}
