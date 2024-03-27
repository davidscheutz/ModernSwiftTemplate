import SwiftCopy
import Core

/// @State(LoginView)
struct LoginState: Inputable, Copyable {
    let inputs: [Input]
    let isLoading: Bool
    let error: String?
    
    static let initial = Self(inputs: [.init(field: .username), .init(field: .password)], isLoading: false, error: nil)
    
    func update(inputs: [Input]) -> LoginState {
        copy(inputs: inputs)
    }
}

/// @Event(LoginView)
enum LoginEvent {
    case inputChanged(field: Input.Field, value: String)
    case login
}
