import SwiftUI

@main
struct TemplateApp: App {

    init() {
        Dependencies.setup()
    }
    
    @StateObject var authenticationManager = Dependencies.authenticationManager
    
    var body: some Scene {
        WindowGroup {
            Group {
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
