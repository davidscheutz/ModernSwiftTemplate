import XCTest
@testable import Template
@testable import Onboarding
import Core

final class TemplateTests: XCTestCase {

    private lazy var authMock = AuthenticationManagerMock()
    
    override func setUpWithError() throws {
        try Dependencies.container.override(AuthenticationManager.self) { self.authMock }
    }

    func testExample() throws {
        let sut = LoginLoop.create(with: Dependencies.container)
        
//        sut.handle(.inputChanged(field: .username, value: <#T##String#>))
        
        sut.handle(.login)
        
        // validate username empty
        
//        sut.handle(.inputChanged(field: .password, value: <#T##String#>))
        
//        sut.handle(.login)
        
        // synchrous
//        sut.currentState
        
        // asynchronous
//        sut.state
    }
}
