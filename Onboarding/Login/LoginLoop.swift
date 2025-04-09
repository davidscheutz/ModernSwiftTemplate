import Foundation
import SwiftEvolution
import Core
import SwiftDependencyContainer

@Alias(for: AuthenticationManager.self)
protocol LoginAuthProvider {
    func login(username: String, password: String) async throws
}
extension AuthenticationManagerImpl: LoginAuthProvider {}

/// @Loop(LoginState, LoginEvent)
@Factory
final class LoginLoop: GeneratedBaseLoginLoop {
    
    private let loginProvider: LoginAuthProvider
    
    init(loginProvider: LoginAuthProvider) {
        self.loginProvider = loginProvider
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
                try await loginProvider.login(username: username, password: password)
            } catch let error {
                updateError(error.localizedDescription)
            }
            
            updateIsLoading(false)
        }
    }
}
