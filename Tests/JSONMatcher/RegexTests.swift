import XCTest
import Nimble
@testable import JSONMatcher

class RegexTestCase: XCTestCase {
    func testMatch() {
        expect(Regex(".+").match("foobar")).to(beTrue())
    }
}
