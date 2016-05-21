import XCTest
import Nimble
@testable import JSONMatcher

class RegexTestCase: XCTestCase {
    func testMatch() {
        expect(".+".regex.match("foobar")).to(beTrue())
    }
}
