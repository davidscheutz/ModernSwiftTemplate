import SwiftCopy

/// @State(CreateView)
struct CreateState: Copyable {
    let title: Input
    let description: Input
    let isLoading: Bool
    let error: String?
    
    static let initial = Self(
        title: .init(title: "Title"),
        description: .init(field: .message(lineLimit: 10), title: "Description"),
        isLoading: false,
        error: nil
    )
}

/// @Event(CreateView)
enum CreateEvent {
    case titleChanged(_ title: String)
    case descriptionChanged(_ title: String)
    case create
    case close
}
