import XCTest

final class ApiKeyPromptTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testPromptVisibilityWithApiKey() throws {
        let app = XCUIApplication()
        app.launchEnvironment["API_KEY"] = ProcessInfo.processInfo.environment["API_KEY"]
        app.launch()
        XCTAssertFalse(app.alerts.staticTexts["Wprowadź klucz API"].exists)
    }
    
    func testPromptVisibilityWithoutApiKey() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.alerts.staticTexts["Wprowadź klucz API"].exists)
    }
}
