import SwiftUI
import SwiftDependencyContainer
import InfiniteNavigation
import Core

public final class Todos {
    public static func start(_ resolver: Resolvable) -> some View {
        let navigation = Navigation.resolve(resolver)
        
        return InfiniteNavigation.create(
            navAction: navigation.publisher,
            viewBuilder: navigation.build(_:)
        ) {
            ListView.create(using: ListLoop.create(using: resolver))
        }
    }
}
//            .banner()
