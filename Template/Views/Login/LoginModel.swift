import SwiftCopy

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
    case inputChanged(Input.Field, String)
    case login
}
