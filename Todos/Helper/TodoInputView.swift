import SwiftUI
import Core

struct TodoInputView: View {
    
    @Binding var title: SimpleTextInput
    @Binding var description: SimpleTextInput
    
    var body: some View {
        VStack(spacing: 24) {
            TextInput(input: $title)
            TextInput(input: $description)
        }
    }
}

#Preview {
    TodoInputView(
        title: .constant(.update("Todo Title")),
        description: .constant(.empty)
    )
    .padding()
}
