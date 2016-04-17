import XCTest
import Nimble

class BeJSONTestCase: XCTestCase {
    func testBeJSON() {
        expect("{}").to(beJSON())
        expect("{").toNot(beJSON())
        expect(10).toNot(beJSON())
    }
}
