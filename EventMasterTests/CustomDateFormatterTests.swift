import XCTest
@testable import EventMaster

final class CustomDateFormatterTests: XCTestCase {
    private let customDateFormatter = CustomDateFormatter()
    private let dateFormatter = DateFormatter()
    
    func testFormatFromISO() {
        XCTAssertEqual(try? customDateFormatter.formatFromISO(date: "2020-07-01"), "01.07.2020")
    }
    
    func testDateFromISO() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        XCTAssertEqual(try? customDateFormatter.dateFromISO(date: "2020-01-01"), dateFormatter.date(from: "2020-01-01"))
    }
    
    func testFormatFromISOWithTime() {
        XCTAssertEqual(try? customDateFormatter.formatFromISO(date: "2020-07-01", time: "20:00:00"), "20:00, 01.07.2020")
    }
    
    func testDateFromISOWithTime() {
        dateFormatter.dateFormat = "HH:mm yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        XCTAssertEqual(try? customDateFormatter.dateFromISO(date: "2020-01-01", time: "20:00"), dateFormatter.date(from: "20:00 2020-01-01"))
    }
    
    func testFormatTime() {
        XCTAssertEqual(customDateFormatter.formatTime(time: "15:00:00"), "15:00")
    }
}
