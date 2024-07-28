import XCTest
@testable import LeftoverChefApp

class RecipeViewModelTest: XCTestCase {
    
    var viewModel: RecipeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RecipeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSearchQuery() {
        viewModel.searchQuery = "Banana"
        XCTAssertEqual(viewModel.searchQuery, "Banana")
    }
}
