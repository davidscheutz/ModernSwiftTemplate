import Foundation
import SwiftCopy
import Core

/// @State(DetailView)
struct DetailState: Copyable {
    let todo: LoadableData<Todo>
    let updatedTitle: SimpleTextInput
    let updatedDescription: SimpleTextInput
    let isUpdating: Bool
    let isDeleting: Bool
}

extension DetailState {
    var title: SimpleTextInput {
        updatedTitle.value.isEmpty ? .init(value: todo.loaded?.title ?? "") : updatedTitle
    }
    
    var description: SimpleTextInput {
        updatedDescription.value.isEmpty ? .init(value: todo.loaded?.description ?? "") : updatedDescription
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

/// @Event(DetailView)
enum DetailEvent {
    case close
    case update
    case delete
    case titleChanged(_ title: String)
    case descriptionChanged(_ description: String)
}
