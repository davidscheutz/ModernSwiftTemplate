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
    
    override func inputChanged(field: Input.Field, value: String) {
        guard !isLoading else { return }
        update { $0.update(value, for: field) }
    }
    
    override func login() {
        guard !isLoading else { return }
        
        let username = inputs.value(for: .username)
        let password = inputs.value(for: .password)
        
        let updatedInputs = inputs
            .validate(field: .username, "Username can't be empty") { !$0.isEmpty }
            .validate(field: .password, "Password can't be empty") { !$0.isEmpty }
        
        guard !updatedInputs.hasErrors else {
            updateInputs(updatedInputs)
            return
        }
        
        update(inputs: updatedInputs, isLoading: true)
        
        Task {
            do {
                try await authenticationManager.login(username: username, password: password)
            } catch let error {
                updateError(error.localizedDescription)
            }
            
            updateIsLoading(false)
        }
    }
}
