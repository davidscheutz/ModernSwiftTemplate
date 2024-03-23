import SwiftUI
import SwiftUDF
import Core

struct CreateView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack {
            Button("Close") { handler(.close) }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Add new Todo")
                .font(.title)
            
            TextInput(input: state.title) { handler(.titleChanged($0)) }
            
            TextInput(input: state.description) { handler(.descriptionChanged($0)) }

            Spacer()
            
//            banner()
            
            PrimaryButton(
                title: "Add",
                isLoading: state.isLoading,
                action: { handler(.create) }
            )
        }
        .padding()
    }
}

#Preview {
    CreateView.preview(.initial)
}
