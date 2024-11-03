import XCTest
@testable import EventMaster

final class EventDetailsViewModelTests: XCTestCase {
    private let viewModel = EventDetailsViewModel(event: mockEvents[0])
    private let secondViewModel = EventDetailsViewModel(event: mockEvents[1])
    
    // Some of the tests will be performed indirectly, all of the view model's values are results of the method mentioned in each function's name
    
    func testFetchPerformer() {
        XCTAssertEqual(viewModel.eventPerformer, "Przykładowy Artysta")
    }
    
    func testFetchDate() {
        XCTAssertEqual(viewModel.eventDate, "15.04.2024")
    }
    
    func testFetchTime() {
        XCTAssertEqual(viewModel.eventTime, "20:00")
        XCTAssertEqual(secondViewModel.eventTime, nil)
    }
    
    func testFetchCountry() {
        XCTAssertEqual(viewModel.eventCountry, "Polska")
    }

    func testFetchCity() {
        XCTAssertEqual(viewModel.eventCity, "Warszawa")
    }
    
    func testFetchVenue() {
        XCTAssertEqual(viewModel.eventVenue, "Przykładowa Lokalizacja")
    }
    
    func testFetchAddress() {
        XCTAssertEqual(viewModel.eventAddress, "123 Przykładowa Ulica")
    }
    
    func testFetchGenre() {
        XCTAssertEqual(viewModel.eventGenre, "Rock")
    }
    
    func testFetchPriceRange() {
        XCTAssertEqual(viewModel.eventPriceRange, "50-150 PLN")
        XCTAssertEqual(secondViewModel.eventPriceRange, "75-250 PLN (opłaty wliczone)")
    }
    
    func testFetchSeatMapURL() {
        XCTAssertEqual(viewModel.eventSeatMap, URL(string: "https://example.com/seatmap1.jpg"))
    }
    
    func testGetFullLocation() {
        XCTAssertEqual(viewModel.getFullLocation(), "Polska, Warszawa, 123 Przykładowa Ulica")
    }
    
    func testGetEventDate() {
        XCTAssertEqual(viewModel.getEventDate(), "20:00, 15.04.2024")
        XCTAssertEqual(secondViewModel.getEventDate(), "20.05.2024")
    }
}
