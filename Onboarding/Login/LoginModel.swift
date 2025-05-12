import SwiftCopy
import Core
import SwiftUDF

@State(LoginView.self)
struct LoginState: Inputable, Copyable {
    let inputs: [Input]
    let isLoading: Bool
    let error: String?
    
    static let initial = Self(inputs: [.username(), .password()], isLoading: false, error: nil)
    
    func update(inputs: [Input]) -> LoginState {
        copy(inputs: inputs)
    }
}

@Event(LoginView.self)
enum LoginEvent {
    case inputChanged(field: Input.Field, value: String)
    case login
}
