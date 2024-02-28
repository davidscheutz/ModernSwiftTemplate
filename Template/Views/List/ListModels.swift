import Foundation
import SwiftCopy

/// @State(ListView)
struct ListState: Copyable {
    let todos: LoadableData<[Todo]>
    
    static let initial = Self.init(todos: .initial)
}

struct Todo: Decodable, Identifiable {
    let id: String
    let createdAt: Date
    let completed: Bool
    let text: String
    let updatedAt: Date?
}

/// @Event(ListView)
enum ListEvent {
    case createTodo
    case openTodo(id: String)
    case logout
}
