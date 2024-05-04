import Foundation

public enum LoadableData<T> {
    case loading
    case loaded(data: T)
    case error(message: String)
    
    public var loaded: T? {
        switch self {
        case .loading, .error:
            return nil
        case .loaded(let data):
            return data
        }
    }
}
