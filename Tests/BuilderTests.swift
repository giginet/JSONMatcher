import XCTest
import Nimble
@testable import JSONMatcher

class Model { }

class BuilderTestCase: XCTestCase {
    var builder: Builder!
    
    override func setUp() {
        super.setUp()
        self.builder = Builder()
    }
    
    func testNumber() {
        let number0 = self.builder.buildJSONElement(10) as! NumberElement
        expect(number0.value).to(equal(10.0))
        let number1 = self.builder.buildJSONElement(10.5) as! NumberElement
        expect(number1.value).to(equal(10.5))
    }
    
    func testString() {
        let string0 = self.builder.buildJSONElement("sushi") as! StringElement
        expect(string0.value).to(equal("sushi"))
    }
    
    func testBoolean() {
        let bool0 = self.builder.buildJSONElement(true) as! BooleanElement
        let bool1 = self.builder.buildJSONElement(false) as! BooleanElement
        expect(bool0.value).to(equal(true))
        expect(bool1.value).to(equal(false))
    }
    
    func testNull() {
        let null0 = self.builder.buildJSONElement(NSNull()) as! NullElement
        expect(null0.value).to(equal(NSNull()))
    }
    
    func testUnknown() {
        let null0 = self.builder.buildJSONElement(Model()) as! NullElement
        expect(null0.value).to(equal(NSNull()))
    }
    
    func testRegex() {
        let regex0 = self.builder.buildJSONElement(Regex(".+")) as! RegexElement
        expect(regex0.value.pattern).to(equal(".+"))
    }
    
    func testType() {
        let type0 = self.builder.buildJSONElement(Type.Number) as! TypeElement
        expect(type0.value).to(equal(Type.Number))
    }
    
    func testArray() {
        let array0 = self.builder.buildJSONElement([
            42,
            10.5,
            "🍺",
            true,
            NSNull(),
            Model(),
            ["cupcake", "donuts", "eclair", "froyo"],
            ["T" : "Tozai", "Z" : "Hanzomon", "H" : "Hibiya"],
        ]) as! ArrayElement
        if let element = array0.value[0] as? NumberElement {
            expect(element.value).to(equal(42))
        }
        if let element = array0.value[1] as? NumberElement {
            expect(element.value).to(equal(10.5))
        }
        if let element = array0.value[2] as? StringElement {
            expect(element.value).to(equal("🍺"))
        }
        if let element = array0.value[3] as? BooleanElement {
            expect(element.value).to(equal(true))
        }
        if let element = array0.value[4] as? NullElement {
            expect(element.value).to(equal(NSNull()))
        }
        if let element = array0.value[5] as? NullElement {
            expect(element.value).to(equal(NSNull()))
        }
        if let element = array0.value[6] as? ArrayElement {
            expect(element.value.count).to(equal(4))
            if let element0 = element.value[0] as? StringElement {
                expect(element0.value).to(equal("cupcake"))
            }
            if let element1 = element.value[1] as? StringElement {
                expect(element1.value).to(equal("donuts"))
            }
            if let element2 = element.value[2] as? StringElement {
                expect(element2.value).to(equal("eclair"))
            }
            if let element3 = element.value[3] as? StringElement {
                expect(element3.value).to(equal("froyo"))
            }
        }
        if let element = array0.value[7] as? DictionaryElement {
            expect(element.value.count).to(equal(3))
            if let element0 = element.value["T"] as? StringElement {
                expect(element0.value).to(equal("Tozai"))
            }
            if let element1 = element.value["Z"] as? StringElement {
                expect(element1.value).to(equal("Hanzomon"))
            }
            if let element2 = element.value["H"] as? StringElement {
                expect(element2.value).to(equal("Hibiya"))
            }
        }
    }
    
    func testDictionary() {
        let dictionary = self.builder.buildJSONElement([
            "int" : 42,
            "double" : 10.5,
            "string" : "🍺",
            "bool" : true,
            "null" : NSNull(),
            "unknown" : Model(),
            "array" : ["cupcake", "donuts", "eclair", "froyo"],
            "dictionary" : ["T" : "Tozai", "Z" : "Hanzomon", "H" : "Hibiya"]
        ]) as! DictionaryElement
        if let element = dictionary.value["int"] as? NumberElement {
            expect(element.value).to(equal(42))
        }
        if let element = dictionary.value["double"] as? NumberElement {
            expect(element.value).to(equal(10.5))
        }
        if let element = dictionary.value["string"] as? StringElement {
            expect(element.value).to(equal("🍺"))
        }
        if let element = dictionary.value["bool"] as? BooleanElement {
            expect(element.value).to(equal(true))
        }
        if let element = dictionary.value["null"] as? NullElement {
            expect(element.value).to(equal(NSNull()))
        }
        if let element = dictionary.value["unknown"] as? NullElement {
            expect(element.value).to(equal(NSNull()))
        }
        if let element = dictionary.value["array"] as? ArrayElement {
            expect(element.value.count).to(equal(4))
            if let element0 = element.value[0] as? StringElement {
                expect(element0.value).to(equal("cupcake"))
            }
            if let element1 = element.value[1] as? StringElement {
                expect(element1.value).to(equal("donuts"))
            }
            if let element2 = element.value[2] as? StringElement {
                expect(element2.value).to(equal("eclair"))
            }
            if let element3 = element.value[3] as? StringElement {
                expect(element3.value).to(equal("froyo"))
            }
        }
        if let element = dictionary.value["dictionary"] as? DictionaryElement {
            expect(element.value.count).to(equal(3))
            if let element0 = element.value["T"] as? StringElement {
                expect(element0.value).to(equal("Tozai"))
            }
            if let element1 = element.value["Z"] as? StringElement {
                expect(element1.value).to(equal("Hanzomon"))
            }
            if let element2 = element.value["H"] as? StringElement {
                expect(element2.value).to(equal("Hibiya"))
            }
        }
    }
    
    func testRecursiveArray() {
        let array = self.builder.buildJSONElement(["a", "b", "c", ["d", "e", ["f", "g", ["h"]]]]) as! ArrayElement
        if let array = array.value[3] as? ArrayElement {
            if let array = array.value[2] as? ArrayElement {
                if let array = array.value[2] as? ArrayElement {
                    if let string = array.value[0] as? StringElement {
                        expect(string.value).to(equal("h"))
                    }
                }
            }
        }
    }
    
    func testRecursiveDictionary() {
        let dictionary = self.builder.buildJSONElement(["a" : ["b" : ["c" : ["d" : ["e", "f", "g", "h"]]]]]) as! DictionaryElement
        if let dictionary = dictionary.value["a"] as? DictionaryElement {
            if let dictionary = dictionary.value["b"] as? DictionaryElement {
                if let dictionary = dictionary.value["c"] as? DictionaryElement {
                    if let array = dictionary.value["d"] as? ArrayElement {
                        if let string = array.value[0] as? StringElement {
                            expect(string.value).to(equal("e"))
                        }
                    }
                }
            }
        }
    }
}
