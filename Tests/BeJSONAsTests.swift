import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONAsTestCase: XCTestCase {
    func testBeJSONAsExactMatch() {
        expect("{\"name\": \"hoge\"}").to(beJSONAs(["name": "hoge"]))
    }
    
    func testBeJSONAsTypeMatching() {
        expect("{\"name\": \"hoge\"}").to(beJSONAs(["name": StringType]))
    }
    
    func testBeJSONAsRegexMatching() {
        expect("{\"name\": \"hoge\"}").to(beJSONAs(["name": Regex("^ho")]))
    }
}
