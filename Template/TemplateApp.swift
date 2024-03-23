import SwiftUI
import InfiniteNavigation
import Core

@main
struct TemplateApp: App {

    init() {
        Dependencies.setup()
        
        navigation = Dependencies.navigation
        
        _authenticationManager = .init(wrappedValue: Dependencies.authenticationManager)
    }
    
    @StateObject private var authenticationManager: AuthenticationManager
    
    private let navigation: Navigation
    
    var body: some Scene {
        WindowGroup {
            if authenticationManager.isLoggedIn {
                MainNavigation.start(Dependencies.container)
            } else {
                OnboardingNavigation.start(Dependencies.container)
            }
            
//            InfiniteNavigation.create(
//                navAction: navigation.publisher,
//                viewBuilder: navigation.build(_:)
//            ) {
//                // TODO: test changes on iOS 15
//                if authenticationManager.isLoggedIn {
//                    MainNavigation.start(Dependencies.container)
//                } else {
//                    OnboardingNavigation.start(Dependencies.container)
//                }
//            }
//            .animation(.easeInOut, value: authenticationManager.isLoggedIn)
//            .banner()
        }
    }
}
