import Foundation
import Combine
import Core
import SwiftEvolution

final class AuthenticationManagerMock: AuthenticationManager {
    var delay: TimeInterval = 0
    var shouldLoginPass = true
    var shouldLogoutPass = true
    
    private(set) var loginCallCount = 0
    private(set) var logoutCallCount = 0
    
    private(set) lazy var isLoggedIn = CurrentValuePublisher<Bool>(_isLoggedIn)
    private let _isLoggedIn = CurrentValueSubject<Bool, Never>(false)
    
    func login(username: String, password: String) async throws {
        loginCallCount += 1
        
        if delay > 0 {
            // TODO: SwiftEvoluation Task.sleep(seconds: TimeInterval)
            try await Task.sleep(nanoseconds: UInt64(delay * 100_000_000))
        }
        
        if shouldLoginPass {
            _isLoggedIn.send(true)
        } else {
            throw NSError(domain: "Login failed", code: 400)
        }
    }
    
    func logout() async {
        logoutCallCount += 1
        
        if shouldLogoutPass {
            _isLoggedIn.send(false)
        }
    }
    
    func reset() {
        _isLoggedIn.send(false)
        shouldLoginPass = true
        shouldLogoutPass = true
        loginCallCount = 0
        logoutCallCount = 0
    }
}
