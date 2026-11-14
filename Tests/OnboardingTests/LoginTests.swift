import XCTest
import SwiftUDF
@testable import Onboarding

extension AuthenticationManagerMock: LoginAuthProvider {}

@MainActor
final class OnboardingTests: XCTestCase {

    var sut: LoginLoop!
    var auth: AuthenticationManagerMock!
    
    override func setUp() async throws {
        auth = AuthenticationManagerMock()
        sut = LoginLoop(loginProvider: auth)
        sut.start()
    }

    func test_loginWithEmptyInputsResultsInInputErrors() {
        sut.handle(.login)
        
        XCTAssertTrue(sut.inputs.hasErrors)
    }
    
    func test_inputIgnoreWhileLoading() {
        let username = "test"
        update(username: username)
        
        let password = "secret"
        update(password: password)
        
        auth.delay = 0.1
        sut.handle(.login)
        
        update(username: "change username attempt")
        XCTAssertEqual(sut.inputs.value(for: .username), username)
        
        update(password: "change password attempt")
        XCTAssertEqual(sut.inputs.value(for: .password), password)
    }
    
    func test_loginFailed() async throws {
        let username = "test"
        update(username: username)
        XCTAssertEqual(sut.inputs.value(for: .username), username)
        
        let password = "secret"
        update(password: password)
        XCTAssertEqual(sut.inputs.value(for: .password), password)
        
        auth.shouldLoginPass = false
        sut.handle(.login)
        
        XCTAssertTrue(sut.isLoading)
        
        try await waitUntil { !self.sut.isLoading }
        
        XCTAssertNotNil(sut.error)
    }
    
    // MARK: - Helper
    
    private func update(username: String) {
        sut.handle(.inputChanged(field: .username, value: username))
    }
    
    private func update(password: String) {
        sut.handle(.inputChanged(field: .password, value: password))
    }

    // MARK: - Wait

    private func waitUntil(timeout: TimeInterval = 1, _ check: @escaping () -> Bool) async throws {
        let deadline = Date().addingTimeInterval(timeout)
        while !check() {
            guard Date() < deadline else {
                throw NSError(domain: "Timeout for wait check...", code: 0)
            }
            try await Task.sleep(nanoseconds: 10_000_000)
        }
    }
}
