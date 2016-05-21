import XCTest
import Nimble
@testable import JSONMatcher

class ElementTestCase: XCTestCase {
    func testNumberElement() {
        let number0 = NumberElement(10)
        let number1 = NumberElement(10.0)
        expect(number0.value).to(equal(number1.value))
        expect(number0.type).to(equal(Type.RawType.Number))
        expect(number1.type).to(equal(Type.RawType.Number))
    }

    func testStringElement() {
        let string0 = StringElement("sushi")
        let string1 = StringElement("🍣")
        expect(string0.value).toNot(equal(string1.value))
        expect(string0.type).to(equal(Type.RawType.String))
        expect(string1.type).to(equal(Type.RawType.String))
    }

    func testBooleanElement() {
        let bool0 = BooleanElement(true)
        let bool1 = BooleanElement(false)
        expect(bool0.value).toNot(equal(bool1.value))
        expect(bool0.type).to(equal(Type.RawType.Boolean))
        expect(bool1.type).to(equal(Type.RawType.Boolean))
    }

    func testNullElement() {
        let null0 = NullElement(NSNull())
        expect(null0.value).to(equal(NSNull()))
        expect(null0.type).to(equal(Type.RawType.Null))
    }

    func testArrayElement() {
        let array0 = ArrayElement([
            NumberElement(10),
            NumberElement(10.5),
            StringElement("sushi"),
            BooleanElement(true),
            NullElement(NSNull())
        ])
        expect(array0.type).to(equal(Type.RawType.Array))
    }

    func testDictionaryElement() {
        let dictionary0 = DictionaryElement([
            "int" : NumberElement(10),
            "double" : NumberElement(10.5),
            "sushi" : StringElement("sushi"),
            "bool" : BooleanElement(true),
            "null" : NullElement(NSNull())
        ])
        expect(dictionary0.type).to(equal(Type.RawType.Dictionary))
    }
}
