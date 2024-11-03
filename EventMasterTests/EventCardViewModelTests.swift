import XCTest
@testable import EventMaster

final class EventCardViewModelTests: XCTestCase {
    private let viewModel = EventCardViewModel(event: mockEvents.first!)
    
    // The tests will be performed indirectly, all of the view model's values are results of the method mentioned in each function's name
    
    func testFetchDate() {
        XCTAssertEqual(viewModel.eventDate, "15.04.2024")
    }
    
    func testFetchCity() {
        XCTAssertEqual(viewModel.eventCity, "Warszawa")
    }
    
    func testFetchVenue() {
        XCTAssertEqual(viewModel.eventVenue, "Przykładowa Lokalizacja")
    }
    
    func testFetchPreviewImageURL() {
        XCTAssertEqual(viewModel.eventPreviewImageURL, URL(string: "https://example.com/image1.jpg"))
    }
}
