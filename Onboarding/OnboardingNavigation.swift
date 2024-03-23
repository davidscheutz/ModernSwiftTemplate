import SwiftUI
import SwiftUDF
import SwiftDependencyContainer

public final class OnboardingNavigation {
    public static func start(_ container: DependencyContainer) -> some View {
        LoginView.create(using: LoginLoop.create(container))
    }
}
