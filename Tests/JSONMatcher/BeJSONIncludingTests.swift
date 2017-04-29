import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONIncludingTestCase: BaseTestCase {
    func testIncludingJSON() {
        expect(["name" : "Pikachu", "no" : 25]).to(beJSONIncluding(["name" : "Pikachu"]))
        expect(["name" : "Pikachu", "no" : 25]).to(beJSONIncluding([:]))
        expect(["name" : "Pikachu", "no" : 25]).toNot(beJSONIncluding(["name" : "Mew"]))
    }

    func testRecursiveDictionary() {
        let snorlax = loadJSONFile("snorlax")
        expect(snorlax).to(beJSONIncluding(["name" : "Snorlax"]))
        expect(snorlax).to(beJSONIncluding(["hp" : 160]))
        expect(snorlax).to(beJSONIncluding(["hp" : 160, "attack" : 110]))
        expect(snorlax).toNot(beJSONIncluding(["hp" : 16, "attack" : 110]))
        expect(snorlax).to(beJSONIncluding(["hp" : 160, "defense" : 65]))
        expect(snorlax).to(beJSONIncluding(["stats" : ["hp" : 160]]))
    }

    func testComplexJSON() {
        let pikachu = loadJSONFile("pikachu")
        expect(pikachu).to(beJSONIncluding(["name" : "swift"]))
        expect(pikachu).to(beJSONIncluding(["name" : "swift", "url" : Type.String]))
    }

    func testFailureMessages() {
        failsWithErrorMessage("expected to include <[\"name\": \"Pikachu\"]>, got <[\"no\": 25, \"name\": \"Pikachu\"]>") {
            expect(["name" : "Pikachu", "no" : 25]).to(beJSONIncluding(["name" : "Pikachu"]))
        }
        failsWithErrorMessage("expected to not include <[\"name\": \"Mew\"]>, got <[\"no\": 25, \"name\": \"Pikachu\"]>") {
            expect(["name" : "Pikachu", "no" : 25]).toNot(beJSONIncluding(["name" : "Mew"]))
        }
    }
}
