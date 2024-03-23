import Foundation
import SwiftCopy
import Core

/// @State(ListView)
struct ListState: Copyable {
    let todos: LoadableData<[Todo]>
    
    static let initial = Self.init(todos: .initial)
}

/// @Event(ListView)
enum ListEvent {
    case createTodo
    case openTodo(id: String)
    case logout
}
