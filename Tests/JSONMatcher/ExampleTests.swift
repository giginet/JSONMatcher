import XCTest
import Nimble
@testable import JSONMatcher

class ExampleTestCase: XCTestCase {
    func testSimpleExamples() {
        expect("{\"name\": \"Pikachu\"}").to(beJSON())
        expect(["name" : "Pikachu", "no" : 25]).to(beJSONIncluding(["name" : "Pikachu"]))
        expect(["name" : "Pikachu", "no" : 25]).to(beJSONAs(["name": "Pikachu", "no" : 25]))
    }

    func testComplexExample() {
        expect([
            "name" : "Snorlax",
            "no" : 143,
            "species" : "Sleeping",
            "type" : ["normal"],
            "stats" : [
                "hp" : 160,
                "attack" : 110,
                "defense" : 65,
                "special_attack" : 65,
                "special_defense" : 65,
                "speed" : 30
            ],
            "moves" : [
                ["name" : "Tackle", "type" : "normal", "level" : 1],
                ["name" : "Hyper Beam", "type" : "normal", "level" : NSNull()],
            ]
        ]).to(beJSONAs([
            "name" : "Snorlax",
            "no" : Type.Number, // value type matching
            "species" : "[a-zA-Z]+".regex, // regular expression matching
            "type" : ["normal"],
            "stats" : [
                "hp" : 160,
                "attack" : 110,
                "defense" : 65,
                "special_attack" : 65,
                "special_defense" : 65,
                "speed" : 30
            ],
            "moves" : [
                ["name" : "Tackle", "type" : "[a-z]+".regex, "level" : Type.Number], // nested collection
                ["name" : "Hyper Beam", "type" : "normal", "level" : NSNull()],
            ]
        ]))
    }
}
