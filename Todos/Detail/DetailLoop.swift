import Foundation
import SwiftUDF
import Core

/// @Factory
/// @Loop(DetailState, DetailEvent)
final class DetailLoop: GeneratedBaseDetailLoop {
    private let bannerManager: BannerManager
    
    init(
        // sourcery: configurable
        id: String,
        bannerManager: BannerManager
    ) {
        self.bannerManager = bannerManager
        super.init(initial: State(todo: .initial))
    }
}
