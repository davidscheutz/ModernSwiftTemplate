import SwiftUI
import Core
import SwiftDependencyContainer

public final class Onboarding {
    public static func start(_ resolver: Resolver) -> some View {
        LoginView.create(using: LoginLoop.create(using: resolver))
    }
}
