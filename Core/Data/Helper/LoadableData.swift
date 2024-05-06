import Foundation

public enum LoadableData<T> {
    case loading
    case loaded(data: T)
    case error(message: String)
    
    public var loaded: T? {
        return switch self {
        case .loading, .error:
            nil
        case .loaded(let data):
            data
        }
    }
    
    public var isError: Bool {
        return switch self {
        case .loading, .loaded:
            false
        case .error:
            true
        }
    }
}
