import XCTest
import Nimble
@testable import JSONMatcher

class ComparerTestCase: XCTestCase {
    func testSimpleStringElement() {
        expect(Comparer.compare(StringElement("foo"), StringElement("foo"))).to(beTrue())
        expect(Comparer.compare(StringElement("foo"), StringElement("bar"))).to(beFalse())
    }
    
    func testSimpleNumberElement() {
        expect(Comparer.compare(NumberElement(10), NumberElement(10))).to(beTrue())
        expect(Comparer.compare(NumberElement(10), NumberElement(10.0))).to(beTrue())
        expect(Comparer.compare(NumberElement(16), NumberElement(0x10))).to(beTrue())
        expect(Comparer.compare(NumberElement(30), NumberElement(30.0000001))).to(beFalse())
    }
    
    func testSimpleBoolElement() {
        expect(Comparer.compare(BooleanElement(true), BooleanElement(true))).to(beTrue())
        expect(Comparer.compare(BooleanElement(false), BooleanElement(true))).to(beFalse())
    }
    
    func testSimpleNilElement() {
        expect(Comparer.compare(NullElement(), NullElement())).to(beTrue())
    }
    
    func testSimpleRegex() {
        expect(Comparer.compare(StringElement("foo"), RegexElement(".+".regex))).to(beTrue())
        expect(Comparer.compare(StringElement("10"), RegexElement("[0-9]{2}".regex))).to(beTrue())
        expect(Comparer.compare(NumberElement(10), RegexElement("10".regex))).to(beFalse())
        expect(Comparer.compare(BooleanElement(false), RegexElement(".+".regex))).to(beFalse())
    }
    
    func testSimpleType() {
        expect(Comparer.compare(NumberElement(42), TypeElement(NumberType.type))).to(beTrue())
        expect(Comparer.compare(NumberElement(42.195), TypeElement(NumberType.type))).to(beTrue())
        expect(Comparer.compare(StringElement("sushi"), TypeElement(NumberType.type))).to(beFalse())
        expect(Comparer.compare(StringElement("🍣"), TypeElement(StringType.type))).to(beTrue())
        expect(Comparer.compare(BooleanElement(true), TypeElement(BooleanType.type))).to(beTrue())
        expect(Comparer.compare(BooleanElement(false), TypeElement(BooleanType.type))).to(beTrue())
        expect(Comparer.compare(NullElement(NSNull()), TypeElement(NullType.type))).to(beTrue())
        expect(Comparer.compare(ArrayElement([StringElement("a"), StringElement("b"), StringElement("c"),]), TypeElement(ArrayType.type))).to(beTrue())        
        expect(Comparer.compare(DictionaryElement(["a" : StringElement("a"), "b" : StringElement("b"), "c" : StringElement("c"),]), TypeElement(DictionaryType.type))).to(beTrue())
        
    }
    
    func testSimpleArray() {
        expect(Comparer.compare(
            ArrayElement([NumberElement(10), NumberElement(20)]),
            ArrayElement([NumberElement(10), NumberElement(20)]))
        ).to(beTrue())
        expect(Comparer.compare(
            ArrayElement([NumberElement(10), StringElement("foo"), BooleanElement(true)]),
            ArrayElement([NumberElement(10), StringElement("foo"), BooleanElement(true)]))
        ).to(beTrue())
        expect(Comparer.compare(
            ArrayElement([NumberElement(10), NumberElement(20)]),
            ArrayElement([NumberElement(10), NumberElement(20), NumberElement(30)]))
        ).to(beFalse())
        expect(Comparer.compare(
            ArrayElement([NumberElement(10), NumberElement(20)]),
            ArrayElement([StringElement("10"), StringElement("20")]))
        ).to(beFalse())
    }
    
    func testSimpleDictionary() {
        expect(Comparer.compare(
            DictionaryElement(["name" : StringElement("bob"), "age": NumberElement(30)]),
            DictionaryElement(["name" : StringElement("bob"), "age": NumberElement(30)]))
        ).to(beTrue())
    }
    
    func testArrayWithRegex() {
        expect(Comparer.compare(
            ArrayElement([NumberElement(10), StringElement("foo"), StringElement("bar"), StringElement("apple")]),
            ArrayElement([NumberElement(10), RegexElement("f+".regex), StringElement("bar"), RegexElement("[a-z]+".regex)]))
        ).to(beTrue())
    }
    
    func testArrayWithType() {
        expect(Comparer.compare(
            ArrayElement([NumberElement(10), StringElement("foo"), StringElement("bar")]),
            ArrayElement([TypeElement(NumberType.type), TypeElement(StringType.type), StringElement("bar")]))
        ).to(beTrue())
    }
    
    func testRecursiveArray() {
        expect(Comparer.compare(
            ArrayElement([StringElement("Articuno"), ArrayElement([ArrayElement([ArrayElement([StringElement("Zapdos")]), StringElement("Moltres")])])]),
            ArrayElement([TypeElement(Type.String), ArrayElement([ArrayElement([ArrayElement([StringElement("Zapdos")]), RegexElement("[A-Z][a-z].+".regex)])])]))
        ).to(beTrue())
    }
    
    func testComplexObject() {
        expect(Comparer.compare(DictionaryElement([
            "name" : StringElement("Charizard"),
            "no" : NumberElement(6),
            "species" : StringElement("Flame"),
            "type" : ArrayElement([StringElement("Fire"), StringElement("Frying")]),
            "stats" : DictionaryElement([
                "hp" : NumberElement(78),
                "attack" : NumberElement(84),
                "defense" : NumberElement(78),
                "special attack" : NumberElement(109),
                "special defense" : NumberElement(85),
                "speed" : NumberElement(100)
            ])
        ]), DictionaryElement([
            "name" : RegexElement("C.+".regex),
            "no" : TypeElement(Type.Number),
            "species" : StringElement("Flame"),
            "type" : ArrayElement([StringElement("Fire"), StringElement("Frying")]),
            "stats" : DictionaryElement([
                "hp" : NumberElement(78),
                "attack" : NumberElement(84),
                "defense" : NumberElement(78),
                "special attack" : NumberElement(109),
                "special defense" : NumberElement(85),
                "speed" : NumberElement(100)
                ])
        ]))).to(beTrue())
    }

}
