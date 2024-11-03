import XCTest

final class AppFlowTests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchEnvironment["API_KEY"] = ProcessInfo.processInfo.environment["API_KEY"]
        app.launch()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        app = nil
    }

    func testEventNavigation() throws {
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        
        XCTAssertTrue(app.navigationBars["Szczegóły"].exists)
    }
    
    func testEventAddToCalendar() throws {
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Dodaj do kalendarza"]/*[[".cells",".buttons[\"Dodaj do kalendarza\"].staticTexts[\"Dodaj do kalendarza\"]",".staticTexts[\"Dodaj do kalendarza\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Dodaj do kalendarza"].scrollViews.otherElements.buttons["OK"].tap()
        
        XCTAssertTrue(app.alerts["Wydarzenie zostało dodane do kalendarza"].exists)
    }
    
    func testEventSorting() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        app.navigationBars["Wydarzenia"].buttons.images["arrow.up.arrow.down.circle"].tap()
        app.collectionViews.buttons["Data"].tap()
        let ascendingDate = app.scrollViews.otherElements.element(boundBy: 0).staticTexts["date"].firstMatch.label.trimmingCharacters(in: .whitespacesAndNewlines)
        app.navigationBars["Wydarzenia"].buttons.images["arrow.up.arrow.down.circle"].tap()
        app.collectionViews.buttons["Data"].tap()
        let descendingDate = app.scrollViews.otherElements.element(boundBy: 0).staticTexts["date"].firstMatch.label.trimmingCharacters(in: .whitespacesAndNewlines)
        
        XCTAssertLessThan(dateFormatter.date(from: ascendingDate)!, dateFormatter.date(from: descendingDate)!)
    }
    
    func testPagination() throws {
        let scrollView = app.scrollViews.firstMatch
        scrollView.firstMatch.swipeUpTo(element: scrollView.otherElements["lastRowView"], maxAttempts: 15, velocity: 1000)
        
        // If the lastRowView is never visible, then new events are loading properly
        XCTAssertFalse(scrollView.otherElements["lastRowView"].exists)
    }
}
