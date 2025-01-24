import XCTest
@testable import Template

final class TemplateTests: XCTestCase {

    /// The Template app target is the composition root,
    /// it's main responsibility is to correctly assemble
    /// all components of the app. This test ensure
    /// all dependencies are registered correctly and
    /// can be retrieved from the container.
    func testDependencies() throws {
        try Dependencies.verifyResolvability()
    }
}
