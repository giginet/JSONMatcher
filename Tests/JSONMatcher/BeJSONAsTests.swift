import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONAsTestCase: BaseTestCase {
    let pokedex: [String: Any] = [
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
        ]
    ]

    func testBeJSONAsExactMatch() {
        expect("{\"name\": \"Snorlax\"}").to(beJSONAs(["name": "Snorlax"]))
    }

    func testBeJSONAsTypeMatching() {
        expect("{\"name\": \"Snorlax\"}").to(beJSONAs(["name": Type.String]))
    }

    func testBeJSONAsRegexMatching() {
        expect("{\"name\": \"Snorlax\"}").to(beJSONAs(["name": "^S".regex]))
    }

    func testBeJSONAsWithDifferentKey() {
        let expected: [String: Any] = [
            "name" : "Snorlax",
            "no" : 143,
            "species" : "Sleeping",
            "type" : ["normal"],
            "stats" : [
                "hp" : 160,
                "invalid" : 110,
                "defense" : 65,
                "special_attack" : 65,
                "special_defense" : 65,
                "speed" : 30
            ]
        ]
        expect(self.pokedex).toNot(beJSONAs(expected))
    }

    func testBeJSONAsExactMatchWithObject() {
        let expected: [String: Any] = [
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
            ]
        ]
        expect(self.pokedex).to(beJSONAs(expected))
    }

    func testBeJSONAsTypeWithObject() {
        let expected: [String: Any] = [
            "name" : Type.String,
            "no" : 143,
            "species" : "Sleeping",
            "type" : ["n+".regex],
            "stats" : [
                "hp" : 160,
                "attack" : 110,
                "defense" : 65,
                "special_attack" : 65,
                "special_defense" : 65,
                "speed" : 30
            ]
        ]
        expect(self.pokedex).to(beJSONAs(expected))
    }

    func testBeJSONAsWithJSONString() {
        let snorlax = loadJSONFile("snorlax")
        expect(snorlax).to(beJSONAs(self.pokedex))
    }
    
    func testComplexJSON() {
        let pikachu = loadJSONFile("pikachu")
        let expected = try! JSONSerialization.jsonObject(with: pikachu.data(using: .utf8)!, options: [])
        expect(pikachu).to(beJSONAs(expected))
    }

    func testFailureMessages() {
        failsWithErrorMessage("expected to equal to <[\"name\": \"Pikachu\"]>, got <[\"name\": \"Snorlax\"]>") {
            expect(["name": "Snorlax"]).to(beJSONAs(["name": "Pikachu"]))
        }
        failsWithErrorMessage("expected to not equal to <[\"name\": \"Snorlax\"]>, got <[\"name\": \"Snorlax\"]>") {
            expect(["name": "Snorlax"]).toNot(beJSONAs(["name": "Snorlax"]))
        }
    }
}
