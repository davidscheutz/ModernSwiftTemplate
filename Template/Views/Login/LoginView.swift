import SwiftUI
import SwiftUDF

struct LoginView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
                .padding(.top, 60)
            
            Spacer()
            
            ForEach(state.inputs) { input in
                TextInput(input: input) { handler(.inputChanged($0, $1)) }
            }
            
            PrimaryButton(title: "Login", isLoading: state.isLoading) { handler(.login) }
            
            Spacer()
        }
        .padding()
        .animateErrors(state.inputs)
    }
}

#Preview("Initial") {
    LoginView.preview(.initial)
}

#Preview("Loading") {
    let state = LoginView.State.initial
        .copy(isLoading: true)
        .update("my_username", for: .username)
        .update("secret", for: .password)
    
    return LoginView.preview(state)
}

#Preview("Input Error") {
    LoginView.preview(.initial.update(error: "Empty input", for: .username))
}
