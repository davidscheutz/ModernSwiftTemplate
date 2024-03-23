import Foundation
import SwiftUI
import SwiftUDF
import SwiftDependencyContainer
import InfiniteNavigation

public final class MainNavigation {
    public static func start(_ container: DependencyContainer) -> some View {
        ListView.create(using: ListLoop.create(container))
    }
}

//            InfiniteNavigation.create(
//                navAction: navigation.publisher,
//                viewBuilder: navigation.build(_:)
//            ) {
//                // TODO: test changes on iOS 15
//                if authenticationManager.isLoggedIn {
//                    MainNavigation.start(Dependencies.container)
//                } else {
//                    OnboardingNavigation.start(Dependencies.container)
//                }
//            }
//            .banner()
