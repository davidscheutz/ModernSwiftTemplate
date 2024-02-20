import Foundation
import SwiftUDF

/// @Factory
/// @Loop(DetailState, DetailEvent)
final class DetailLoop: GeneratedBaseDetailLoop {
    private let bannerManager: BannerManager
    
    init(id: String, bannerManager: BannerManager) {
        self.bannerManager = bannerManager
        super.init(initial: State(todo: .initial))
    }
}
