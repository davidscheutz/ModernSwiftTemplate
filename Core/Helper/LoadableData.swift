import Foundation

public enum LoadableData<T> {
    case initial
    case loading
    case loaded(data: T)
    case error(message: String)
    
    public var loaded: T? {
        switch self {
        case .initial, .loading, .error:
            return nil
        case .loaded(let data):
            return data
        }
    }
}
