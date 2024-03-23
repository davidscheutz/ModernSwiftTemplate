import Foundation
import SwiftCopy
import Core

/// @State(DetailView)
struct DetailState: Copyable {
    let todo: LoadableData<Todo>
}

/// @Event(DetailView)
enum DetailEvent {
    case close
    case update
    case delete
    case inputChanged(Input.Field, String)
}
