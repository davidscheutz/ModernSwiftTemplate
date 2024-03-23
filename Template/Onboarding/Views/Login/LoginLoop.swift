import Foundation
import SwiftEvolution
import Core

/// @Factory

/// @Loop(LoginState, LoginEvent)
final class LoginLoop: GeneratedBaseLoginLoop {
    
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
        super.init(initial: .initial)
    }
    
    override func inputChanged(inputField1: Input.Field, string2: String) {
        guard !currentState.isLoading else { return }
        
        update { $0.update(string2, for: inputField1) }
    }
    
    override func login() {
        let state = currentState
        
        guard !state.isLoading else { return }
        
        let username = state.inputs.value(for: .username)
        let password = state.inputs.value(for: .password)
        
//        let updatedInputs = state.inputs
//            .validate(field: .username) { "Username can't be empty".take(if: $0.isEmpty) }
//            .validate(field: .password) { "Password can't be empty".take(if: $0.isEmpty) }
//        
//        guard !updatedInputs.hasErrors else {
//            update(state.copy(inputs: updatedInputs))
//            return
//        }
//        
//        update(state.copy(inputs: updatedInputs, isLoading: true))
        
        Task {
            await authenticationManager.login(username: username, password: password)
        }
    }
}
