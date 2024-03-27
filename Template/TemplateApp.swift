import SwiftUI
import Core
import Onboarding
import Todos

@main
struct TemplateApp: App {

    init() {
        Appearance.setup()
        
        Dependencies.setup()
        
        _authenticationManager = .init(wrappedValue: Dependencies.authenticationManager)
    }
    
    @StateObject private var authenticationManager: AuthenticationManager
    
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
            }
            .animation(.easeInOut, value: authenticationManager.isLoggedIn)
        }
    }
}
