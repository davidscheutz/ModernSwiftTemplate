import Foundation
import SwiftUI

enum Gravity {
    case top, bottom
    
    var alignment: Alignment {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
    
    var edgeSet: Edge.Set {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}

extension View {
    
    func banner(gravity: Gravity = .bottom) -> some View {
        modifier(BannerViewModifier(gravity: gravity))
    }
}

struct BannerViewModifier: ViewModifier {
    private let bannerManager = Dependencies.bannerManager
    
    @State private var config: BannerView.Config?
    
    let gravity: Gravity
    
    func body(content: Content) -> some View {
        content.overlay(alignment: gravity.alignment) {
            if let config {
                BannerView(config: config)
                    .padding(gravity.edgeSet, 10)
                    .padding(.horizontal, 20)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: config != nil)
        .onAppear {} // subscribe
        .onDisappear {} // unsubscribe
        .onReceive(bannerManager.subscribe().receiveOnMain()) { config = $0 }
    }
}
