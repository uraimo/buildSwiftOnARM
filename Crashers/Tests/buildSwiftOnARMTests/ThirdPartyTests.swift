import XCTest
import SwiftyJSON

typealias JsonDict = [String: JSON]

final class SwiftyJsonTests: XCTestCase {
    func testParsingDouble() {
        // This started having problems on Swift 4.2
	let jsonData: JsonDict = [
            "works": 2.4,
            "shouldWork": 0.3
        ]

        let json = JSON(jsonData)
        XCTAssertEqual(json["works"].number?.doubleValue, 2.4)
        XCTAssertEqual(json["shouldWork"].number?.doubleValue, 0.3)
    }

    static var allTests = [
        ("testParsingDouble", testParsingDouble),
    ]
}
