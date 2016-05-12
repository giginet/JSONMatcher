import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONAsTestCase: XCTestCase {
    let pokedex = [
        "name" : "snorlax",
        "no" : 143,
        "species" : "Sleeping",
        "type" : ["normal"],
        "stats" : [
            "hp" : 160,
            "attack" : 110,
            "defense" : 65,
            "special attack" : 65,
            "special defense" : 65,
            "speed" : 30
        ]
    ]
    
    func testBeJSONAsExactMatch() {
        expect("{\"name\": \"hoge\"}").to(beJSONAs(["name": "hoge"]))
    }
    
    func testBeJSONAsTypeMatching() {
        expect("{\"name\": \"hoge\"}").to(beJSONAs(["name": StringType]))
    }
    
    func testBeJSONAsRegexMatching() {
        expect("{\"name\": \"hoge\"}").to(beJSONAs(["name": Regex("^ho")]))
    }
    
    func testBeJSONAsExactMatchWithObject() {
        let expected = [
            "name" : "snorlax",
            "no" : 143,
            "species" : "Sleeping",
            "type" : ["normal"],
            "stats" : [
                "hp" : 160,
                "attack" : 110,
                "defense" : 65,
                "special attack" : 65,
                "special defense" : 65,
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
                "special attack" : 65,
                "special defense" : 65,
                "speed" : 30
            ]
        ]
        expect(self.pokedex).to(beJSONAs(expected))
    }
}
