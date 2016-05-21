import XCTest
import Nimble
@testable import JSONMatcher

class RegexTestCase: XCTestCase {
    func testMatch() {
        expect(".+".regex.match("foobar")).to(beTrue())
    }

    func testRegex() {
        let regex = ".+".regex
        let expected = try! NSRegularExpression(pattern: ".+", options: [])
        expect(regex.pattern).to(equal(expected.pattern))
        expect(regex.options).to(equal(expected.options))
    }
}
