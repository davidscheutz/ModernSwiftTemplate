import SwiftUI
import Core
import Onboarding

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
                    MainNavigation.start(Dependencies.container)
                } else {
                    OnboardingNavigation.start(Dependencies.container)
                }
            }
            .animation(.easeInOut, value: authenticationManager.isLoggedIn)
        }
    }
}
