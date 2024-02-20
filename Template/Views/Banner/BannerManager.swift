import Foundation
import Combine
import Combine

/// @Singleton
final class BannerManager {
    
    static let defaultDismissDuration: TimeInterval = 2
    
//    @Published private(set) var config: BannerView.Config?
    private let config = CurrentValueSubject<BannerView.Config?, Never>(nil)
    private var subscriptionsCount = 0
    
    //public func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
    func subscribe() -> AnyPublisher<BannerView.Config?, Never> {
//        config.subscribe(<#T##subscriber: Subscriber##Subscriber#>)
        
        config.eraseToAnyPublisher()
    }
    
    func present(_ config: BannerView.Config, dismissDuration: TimeInterval? = BannerManager.defaultDismissDuration) {
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
