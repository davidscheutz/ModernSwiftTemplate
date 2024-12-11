import SwiftUI
import Core
import Onboarding
import Todos

@main
struct TemplateApp: App {

    init() {
        Dependencies.setup()
        Appearance.setup()
    }
    
    @StateObject private var coordinator = Dependencies.rootCoordinator
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Dependencies.apply {
                    switch coordinator.state {
                    case .loggedIn: Todos.start($0)
                    case .loggedOut: Onboarding.start($0)
                    }
                }
                .transition(.opacity)
            }
            .animation(.easeInOut, value: coordinator.state)
        }
    }
}
