import XCTest
@testable import Todos

final class TodosTests: XCTestCase {
    var sut: DetailLoop!
    
    override func setUpWithError() throws {
        sut = DetailLoop(id: <#T##String#>, todosService: <#T##TodosService#>, navigation: <#T##Navigation#>, bannerManager: <#T##BannerManager#>)
        sut.start()
    }

    func test_initialStateNoChanges() {
        
    }
}
