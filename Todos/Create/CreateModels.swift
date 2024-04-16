import SwiftCopy
import Core

/// @State(CreateView)
struct CreateState: Copyable {
    let title: SimpleTextInput
    let description: SimpleTextInput
    let isLoading: Bool
    let error: String?
    
    static let initial = Self(title: .empty, description: .empty, isLoading: false, error: nil)
}

/// @Event(CreateView)
enum CreateEvent {
    case titleChanged(_ title: String)
    case descriptionChanged(_ description: String)
    case create
    case close
}
