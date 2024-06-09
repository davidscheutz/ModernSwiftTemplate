import SwiftUI
import SwiftUDF
import SwiftEvolution
import Core

struct DetailView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack {
            NavigationHeader(
                title: state.todo.loaded?.title,
                actions: [
                    .init(value: .titleIcon("Back", .init(systemName: "arrowshape.backward.fill")), position: .left, perform: { handler(.close) }),
                    deleteNavigationAction
                ].compactMap { $0 }
            )
            .padding(.bottom)
            
            LoadableView(data: state.todo) { todo in
                TodoInputView(
                    title: .init(get: { state.title }, set: { handler(.titleChanged($0.value)) }),
                    description: .init(get: { state.description }, set: { handler(.descriptionChanged($0.value)) })
                )
                
                Spacer()
                
                if state.hasChanges {
                    PrimaryButton(title: "Update", isLoading: state.isUpdating) { handler(.update) }
                }
            }
        }
        .padding()
    }
    
    private var deleteNavigationAction: NavigationHeader.Action? {
        guard state.todo.loaded != nil else { return nil }
        
        return state.isDeleting ?
            .init(value: .loading, position: .right, perform: {}) :
            .init(value: .icon(.init(systemName: "trash")), position: .right, perform: { handler(.delete) })
    }
}

#Preview("Loaded") {
    DetailView.preview(.preview())
}

#Preview("Invalid Update") {
    DetailView.preview(.preview().copy(
        updatedDescription: .init(value: "Invalid description", error: "Error")
    ))
}

#Preview("Updating") {
    DetailView.preview(.preview().copy(
        updatedDescription: .init(value: "Updated description", error: nil),
        isUpdating: true
    ))
}

#Preview("Deletion") {
    DetailView.preview(.preview().copy(isDeleting: true))
}

#Preview("Error") {
    DetailView.preview(.preview(todo: .error(message: "Preview Error")))
}

#Preview("Loading") {
    DetailView.preview(.preview(todo: .loading))
}
