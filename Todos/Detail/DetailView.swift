import SwiftUI
import SwiftUDF
import SwiftEvolution
import Core

/// @Bind(DetailLoop)
struct DetailView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack {
            LoadableView(data: state.todo) { todo in
                NavigationHeader(
                    title: todo.title,
                    actions: [
                        .init(value: .titleIcon("Back", .init(systemName: "arrowshape.backward.fill")), position: .left, perform: { handler(.close) }),
                        deleteNavigationAction
                    ]
                )
                .padding(.bottom)
                
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
    
    private var deleteNavigationAction: NavigationHeader.Action {
        state.isDeleting ?
            .init(value: .loading, position: .right, perform: {}) :
            .init(value: .icon(.init(systemName: "trash")), position: .right, perform: { handler(.delete) })
    }
}

#Preview("Loaded") {
    DetailView.preview(.loadedPreviewState)
}

#Preview("Invalid Update") {
    DetailView.preview(.loadedPreviewState.copy(
        updatedDescription: .init(value: "Invalid description", error: "Error")
    ))
}

#Preview("Updating") {
    DetailView.preview(.loadedPreviewState.copy(
        updatedDescription: .init(value: "Updated description", error: nil),
        isUpdating: true
    ))
}

#Preview("Deletion") {
    DetailView.preview(.loadedPreviewState.copy(isDeleting: true))
}
