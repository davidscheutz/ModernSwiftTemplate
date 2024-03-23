import Foundation
import SwiftUI
import SwiftUDF
import SwiftDependencyContainer

public final class MainNavigation {
    public static func start(_ container: DependencyContainer) -> some View {
        ListView.create(using: ListLoop.create(container))
    }
}
