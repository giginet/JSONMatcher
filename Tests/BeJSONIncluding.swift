import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONIncluding: BaseTestCase {
    func testIncludingComplexJSON() {
        let pikachu = loadJSONFile("pikachu")
        expect(pikachu).to(beJSONIncluding([
            "name" : "swift",
            "url" : StringType
        ]))
    }
}
