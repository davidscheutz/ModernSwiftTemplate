import SwiftCopy
import Core
import SwiftUDF

@State(CreateView.self)
struct CreateState: Copyable {
    let title: SimpleTextInput
    let description: SimpleTextInput
    let isLoading: Bool
    let error: String?
    
    static let initial = Self(title: .empty, description: .empty, isLoading: false, error: nil)
}

@Event(CreateView.self)
enum CreateEvent {
    case titleChanged(_ title: String)
    case descriptionChanged(_ description: String)
    case create
    case close
}
