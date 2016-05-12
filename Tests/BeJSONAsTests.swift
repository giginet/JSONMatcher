import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONAsTestCase: BaseTestCase {
    let pokedex = [
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
        expect("{\"name\": \"Snorlax\"}").to(beJSONAs(["name": StringType]))
    }
    
    func testBeJSONAsRegexMatching() {
        expect("{\"name\": \"Snorlax\"}").to(beJSONAs(["name": Regex("^S")]))
    }
    
    func testBeJSONAsWithDifferentKey() {
        let expected = [
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
        let expected = [
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
        let expected = [
            "name" : StringType,
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
}
