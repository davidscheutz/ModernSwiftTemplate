import XCTest
import SwiftUDF
@testable import Onboarding

final class OnboardingTests: XCTestCase {

    var sut: LoginLoop!
    var auth: AuthenticationManagerMock!
    
    override func setUpWithError() throws {
        auth = AuthenticationManagerMock()
        sut = LoginLoop(authenticationManager: auth)
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
        
        update(username: "change attempt")
        XCTAssertEqual(sut.inputs.value(for: .username), username)
        
        update(password: "change attempt")
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
        
        try await sut.wait { !$0.isLoading }
        
        XCTAssertNotNil(sut.error)
    }
    
    // MARK: - Helper
    
    private func update(username: String) {
        sut.handle(.inputChanged(field: .username, value: username))
    }
    
    private func update(password: String) {
        sut.handle(.inputChanged(field: .password, value: password))
    }
}
