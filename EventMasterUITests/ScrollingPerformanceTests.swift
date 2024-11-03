import XCTest

final class ScrollingPerformanceTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment["API_KEY"] = ProcessInfo.processInfo.environment["API_KEY"]
        app.launch()
    }
    
    override func tearDown()  {
        super.tearDown()
        app = nil
    }
    
    func testEventListScrolling() throws {
        measure(metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric]) {
            app.swipeUp(velocity: 1000)
        }
    }
    
    func testEventDetailsScrolling() throws {
        app.scrollViews.buttons.firstMatch.tap()
        
        XCTAssert(app.navigationBars["Szczegóły"].exists)
        
        measure(metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric]) {
            app.swipeUp()
            app.swipeDown()
        }
    }
}
