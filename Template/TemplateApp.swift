import SwiftUI
import Core
import Onboarding
import Todos

@main
struct TemplateApp: App {

    init() {
        Appearance.setup()
        
        Dependencies.setup()
        
        _authenticationManager = .init(wrappedValue: Dependencies.authenticationManagerImpl)
    }
    
    @StateObject private var authenticationManager: AuthenticationManagerImpl
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Dependencies.apply {
                    if authenticationManager.isLoggedIn {
                        Todos.start($0)
                    } else {
                        Onboarding.start($0)
                    }
                }
                .transition(.opacity)
            }
            .animation(.easeInOut, value: authenticationManager.isLoggedIn)
        }
    }
}
