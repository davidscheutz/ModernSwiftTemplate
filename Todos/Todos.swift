import SwiftUI
import SwiftDependencyContainer
import InfiniteNavigation
import Core

public final class Todos {
    public static func start(_ resolver: Resolvable) -> some View {
        ListView.create(using: ListLoop.create(using: resolver))
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
