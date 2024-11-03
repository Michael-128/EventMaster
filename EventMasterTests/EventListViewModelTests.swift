import XCTest
@testable import EventMaster

final class EventListViewModelTests: XCTestCase {
    func testResetEvents() throws {
        let viewModel = EventListViewModel()
        
        viewModel.events = mockEvents
        viewModel.nextPage = 2
        viewModel.paginationStatus = .noMoreData
        
        XCTAssertTrue(viewModel.events.count != 0)
        XCTAssertTrue(viewModel.nextPage != 0)
        XCTAssertTrue(viewModel.paginationStatus != .ready)
        
        viewModel.resetEvents()
        
        XCTAssertTrue(viewModel.events.count == 0)
        XCTAssertTrue(viewModel.nextPage == 0)
        XCTAssertTrue(viewModel.paginationStatus == .ready)
    }
    
    func testSetSortOption() throws {
        let viewModel = EventListViewModel()
        
        // If the same sort option is passed - isAscending should toggle
        viewModel.setSortOption(.name)
        
        XCTAssertTrue(viewModel.sortOption == .name)
        XCTAssertTrue(viewModel.isAscending == true)
        
        viewModel.setSortOption(.name)
        
        XCTAssertTrue(viewModel.sortOption == .name)
        XCTAssertTrue(viewModel.isAscending == false)
        
        
        // If the sort option is set to random, toggling isAscending shouldn't be allowed
        viewModel.setSortOption(.random)
        
        XCTAssertTrue(viewModel.sortOption == .random)
        XCTAssertTrue(viewModel.isAscending == true)
        
        viewModel.setSortOption(.random)
        
        XCTAssertTrue(viewModel.sortOption == .random)
        XCTAssertTrue(viewModel.isAscending == true)
    }
    
    func testGetSortOption() throws {
        let viewModel = EventListViewModel()
        
        viewModel.setSortOption(.name)
        XCTAssertTrue(viewModel.getSortOption() == "name,asc")
        
        viewModel.setSortOption(.name)
        XCTAssertTrue(viewModel.getSortOption() == "name,desc")
        
        viewModel.setSortOption(.random)
        XCTAssertTrue(viewModel.getSortOption() == "random")
    }
}
