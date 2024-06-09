#if DEBUG
extension Todo {
    static let preview1 = Todo(id: "1", createdAt: .now, completed: false, title: "Master SwiftUI Animations", description: "Native Mobile Development\n- iOS\n- Android", updatedAt: nil)
    static let preview2 = Todo(id: "2", createdAt: .now, completed: false, title: "Relax", description: nil, updatedAt: nil)
    static let preview3 = Todo(id: "3", createdAt: .now, completed: false, title: "Add readme", description: "Life", updatedAt: nil)
}

import Core

extension Input {
    static let previewUsernameEmpty = Input(field: .username)
    static let previewUsernamePlaceholder = Input(field: .username, placeholder: "Enter your Username")
    static let previewUsernameFilled = Input(field: .username, value: "username")
    static let previewPasswordEmpty = Input(field: .password)
    static let previewPasswordFilled = Input(field: .password, value: "secret")
    static let previewMessageEmpty = Input(field: .message(lineLimit: 5))
}

extension DetailView.State {
    static func preview(todo: LoadableData<Todo> = .loaded(data: .preview1)) -> DetailView.State {
        DetailView.State(todo: todo, updatedTitle: .empty, updatedDescription: .empty, isUpdating: false, isDeleting: false, error: nil)
    }
}
#endif
