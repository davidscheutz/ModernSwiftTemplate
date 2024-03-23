import SwiftUI
import SwiftUDF
import SwiftEvolution
import Core

struct ListView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        VStack {
            Button("Logout") { handler(.logout) }
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Your Todo's 📋")
                .font(.title)
//                .foregroundStyle(Color.textPrimary)
            
            LoadableListView(data: state.todos) { todo in
                HStack {
                    Text(todo.text)
                    Spacer()
                    // TODO: icon
                }
                .clickable { handler(.openTodo(id: todo.id)) }
            }
            
            PrimaryButton(title: "Add Todo") { handler(.createTodo) }
        }
        .padding()
    }
}

#Preview("Empty") {
    ListView.preview(.initial)
}

#Preview("Loaded") {
    let state = ListState(todos: .loaded(data: [
        .init(id: "1", createdAt: .now, completed: false, text: "Master", updatedAt: nil),
        .init(id: "2", createdAt: .now, completed: false, text: "Relax", updatedAt: nil),
        .init(id: "3", createdAt: .now, completed: false, text: "Enjoy", updatedAt: nil)
    ]))
    return ListView.preview(state)
}

#Preview("Error") {
    ListView.preview(.initial.copy(todos: .error(message: "Preview Error")))
}
