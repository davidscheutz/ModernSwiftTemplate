import Foundation

public enum LoadableData<T> {
    case initial
    case loading
    case loaded(data: T)
    case error(message: String)
}
