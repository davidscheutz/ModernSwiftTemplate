import Foundation
import Combine
import Combine

public struct Config {
    public init(title: String, type: MessageType, action: Action? = nil) {
        self.title = title
        self.type = type
        self.action = action
    }
    
    let title: String
    let type: MessageType
    let action: Action?
    
    public static func success(_ title: String) -> Self {
        Self(title: title, type: .success)
    }
    
    public static func error(_ error: String, action: Action? = nil) -> Self {
        Self(title: error, type: .error, action: action)
    }
}

public enum MessageType {
    case success
    case info
    case error
    
    fileprivate var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .info: return "info.circle.fill"
        case .error: return "exclamationmark.circle.fill"
        }
    }
}

public struct Action {
    let title: String
    let completion: Completion
    
    public init(title: String, completion: @escaping Completion) {
        self.title = title
        self.completion = completion
    }
    
    public static func retry(_ action: @escaping Completion) -> Self {
        .init(title: "Retry", completion: action)
    }
}

/// @Singleton
public final class BannerManager {
    
    public static let defaultDismissDuration: TimeInterval = 2
    
//    @Published private(set) var config: BannerView.Config?
    private let config = CurrentValueSubject<Config?, Never>(nil)
    private var subscriptionsCount = 0
    
    //public func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
    public func subscribe() -> AnyPublisher<Config?, Never> {
//        config.subscribe(<#T##subscriber: Subscriber##Subscriber#>)
        
        config.eraseToAnyPublisher()
    }
    
    public func present(_ config: Config, dismissDuration: TimeInterval? = BannerManager.defaultDismissDuration) {
        guard self.config.value == nil else {
            // TODO: how to handle multiple banners? (visually stack, queue, overlap etc.)
            return
        }
        
        self.config.send(config)
        
        if let dismissDuration {
            // automatically dismiss banner
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration) { [weak self] in
                self?.config.send(nil)
            }
        }
    }
}
