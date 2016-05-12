import XCTest
import Nimble
@testable import JSONMatcher

class BeJSONTestCase: BaseTestCase {
    func testBeJSONWithObject() {
        expect(10).to(beJSON())
        expect(10.1).to(beJSON())
        expect(["Buibasaur", "Charmander", "Squirtle"]).to(beJSON())
        expect(NSNull()).to(beJSON())
        expect(NSObject()).toNot(beJSON())
    }
    
    func testBeJSONWithJSONString() {
        expect("Pikachu").toNot(beJSON())
        expect("{}").to(beJSON())
        expect("{").toNot(beJSON())
        
        let json = loadJSONFile("snorlax")
        expect(json).to(beJSON())
        
        let pikachu = loadJSONFile("pikachu")
        expect(pikachu).to(beJSON())
    }
}
