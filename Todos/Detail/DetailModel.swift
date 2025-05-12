import Foundation
import SwiftCopy
import Core
import SwiftUDF

@State(DetailView.self)
struct DetailState: Copyable {
    let todo: LoadableData<Todo>
    let updatedTitle: SimpleTextInput
    let updatedDescription: SimpleTextInput
    let isUpdating: Bool
    let isDeleting: Bool
    let error: String?
}

extension DetailState {
    var title: SimpleTextInput {
        hasChanges ? updatedTitle : .init(value: todo.loaded?.title ?? "")
    }
    
    var description: SimpleTextInput {
        hasChanges ? updatedDescription : .init(value: todo.loaded?.description ?? "")
    }
    
    var canEdit: Bool {
        todo.loaded != nil
    }
    
    var hasChanges: Bool {
        !updatedTitle.value.isEmpty && updatedTitle.value != todo.loaded?.title ?? ""
            || !updatedDescription.value.isEmpty && updatedDescription.value != todo.loaded?.description ?? ""
    }
    
    var isLoading: Bool {
        isUpdating || isDeleting
    }
}

@Event(DetailView.self)
enum DetailEvent {
    case close
    case update
    case delete
    case titleChanged(_ title: String)
    case descriptionChanged(_ description: String)
}
