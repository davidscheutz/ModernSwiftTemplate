import Core

final class AuthenticationManagerMock: AuthenticationManager {
    var shouldLoginPass = true
    var shouldLogoutPass = true
    
    private(set) var isLoggedIn = false
    private(set) var loginCallCount = 0
    private(set) var logoutCallCount = 0
    
    func login(username: String, password: String) async {
        loginCallCount += 1
        
        if shouldLoginPass {
            isLoggedIn = true
        }
    }
    
    func logout() async {
        logoutCallCount += 1
        
        if shouldLogoutPass {
            isLoggedIn = false
        }
    }
    
    func reset() {
        isLoggedIn = false
        shouldLoginPass = true
        shouldLogoutPass = true
        loginCallCount = 0
        logoutCallCount = 0
    }
}
