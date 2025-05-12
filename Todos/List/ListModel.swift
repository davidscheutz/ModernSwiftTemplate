import Foundation
import SwiftCopy
import Core
import SwiftUDF

@State(ListView.self)
struct ListState: Copyable {
    let todos: LoadableData<[Todo]>
    
    static let initial = ListState(todos: .loading)
}

@Event(ListView.self)
enum ListEvent {
    case createTodo
    case openTodo(id: String)
    case logout
}
