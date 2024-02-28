import SwiftUI
import InfiniteNavigation

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
            InfiniteNavigation.create(
                navAction: navigation.publisher,
                viewBuilder: navigation.build(_:)
            ) {
                // TODO: test changes on iOS 15
                if authenticationManager.isLoggedIn {
                    ListView.create(using: ListLoop.create())
                } else {
                    LoginView.create(using: LoginLoop.create())
                }
            }
            .animation(.easeInOut, value: authenticationManager.isLoggedIn)
            .banner()
        }
    }
}
