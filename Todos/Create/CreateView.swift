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
            
            TodoInputView(
                title: .init(get: { state.title }, set: { handler(.titleChanged($0.value)) }),
                description: .init(get: { state.description }, set: { handler(.descriptionChanged($0.value)) })
            )

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
