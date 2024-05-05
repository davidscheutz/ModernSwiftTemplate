import SwiftUI
import Core
import Onboarding
import Todos

@main
struct TemplateApp: App {

    init() {
        Appearance.setup()
        
        Dependencies.setup()
    }
    
    @StateObject private var coordinator = Dependencies.rootCoordinator
    
    var body: some Scene {
        WindowGroup {
            /// Depending on your app this will vary.
            /// Most apps I've seen :
            
            /// - UNAUTHENTICATED
            /// -- Login
            /// -- Signup/Onboarding
            
            /// - AUTHENTICATED
            /// -- TabBar
            /// --- Features Scope A
            /// --- Features Scope B
            /// ...
            
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
