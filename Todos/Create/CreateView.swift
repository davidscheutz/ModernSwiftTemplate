import SwiftUI
import SwiftUDF
import Core

struct CreateView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            NavigationHeader(
                title: "Add new Todo",
                actions: [.init(value: .title("Close"), position: .left, perform: { handler(.close) })]
            )
            
            TextInput(input: state.title) { handler(.titleChanged($0)) }
            
            TextInput(input: state.description) { handler(.descriptionChanged($0)) }

            Spacer()
            
            PrimaryButton(
                title: "Add",
                isLoading: state.isLoading,
                action: { handler(.create) }
            )
        }
        .animateErrors([state.title])
        .padding()
    }
}

#Preview {
    CreateView.preview(.initial)
}
