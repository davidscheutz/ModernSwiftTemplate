import SwiftUI
import SwiftUDF
import SwiftEvolution
import Core

struct ListView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack {
            NavigationHeader(
                title: "Your Todo's 📋",
                actions: [.init(value: .title("Logout"), position: .right, perform: { handler(.logout) })]
            )
            
            LoadableListView(data: state.todos) { todo in
                HStack {
                    Text(todo.title).style()
                    Spacer()
                    // TODO: icon
                }
                .clickable { handler(.openTodo(id: todo.id)) }
            }
            
            PrimaryButton(title: "Add Todo") { handler(.createTodo) }
        }
        .padding()
        .background()
    }
}

#Preview("Empty") {
    ListView.preview(.initial)
}

#Preview("Loaded") {
    ListView.preview(.init(todos: .loaded(data: [.preview1, .preview2, .preview3])))
}

#Preview("Error") {
    ListView.preview(.initial.copy(todos: .error(message: "Preview Error")))
}
