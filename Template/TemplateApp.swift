import SwiftUI
import Core
import Onboarding
import Todos

@main
struct TemplateApp: App {

    init() {
        Dependencies.setup()
        
        _authenticationManager = .init(wrappedValue: Dependencies.authenticationManager)
    }
    
    @StateObject private var authenticationManager: AuthenticationManager
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if authenticationManager.isLoggedIn {
                    Todos.start(Dependencies.container)
                } else {
                    Onboarding.start(Dependencies.container)
                }
            }
            .animation(.easeInOut, value: authenticationManager.isLoggedIn)
        }
    }
}
