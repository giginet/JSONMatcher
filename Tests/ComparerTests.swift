import XCTest
import Nimble
@testable import JSONMatcher

class CompareTestCase: XCTestCase {
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
            DictionaryElement(["name" : StringElement("Jigglypuff"), "no": NumberElement(39)]),
            DictionaryElement(["name" : StringElement("Jigglypuff"), "no": NumberElement(39)]))
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
        expect(Comparer.compare(
            ArrayElement([StringElement("Articuno"), ArrayElement([ArrayElement([ArrayElement([StringElement("Zapdos")]), StringElement("Moltres")])])]),
            ArrayElement([TypeElement(Type.String), ArrayElement([ArrayElement([ArrayElement([StringElement("Jigglypuff")]), RegexElement("[A-Z][a-z].+".regex)])])]))
        ).to(beFalse())
    }
    
    func testRecursiveDictionary() {
        expect(Comparer.compare(
            DictionaryElement(["moves" : DictionaryElement(["name" : StringElement("Swift"), "type" : StringElement("normal")])]),
            DictionaryElement(["moves" : DictionaryElement(["name" : StringElement("Swift"), "type" : StringElement("normal")])]))
        ).to(beTrue())
        expect(Comparer.compare(
            DictionaryElement(["moves" : DictionaryElement(["name" : StringElement("Swift"), "type" : StringElement("normal")])]),
            DictionaryElement(["moves" : DictionaryElement(["type" : StringElement("Swift"), "name" : StringElement("normal")])]))
        ).to(beFalse())
        expect(Comparer.compare(
            DictionaryElement(["moves" : DictionaryElement(["name" : StringElement("Swift"), "type" : StringElement("normal")])]),
            DictionaryElement(["moves" : DictionaryElement(["invalid" : StringElement("Swift"), "type" : StringElement("normal")])]))
        ).to(beFalse())
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
                "special_attack" : NumberElement(109),
                "special_defense" : NumberElement(85),
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
                "special_attack" : NumberElement(109),
                "special_defense" : NumberElement(85),
                "speed" : NumberElement(100)
                ])
        ]))).to(beTrue())
    }
}

class IncludeTestCase: XCTestCase {
    func testIncludeExactMatch() {
        expect(Comparer.include(NumberElement(151), NumberElement(151))).to(beTrue())
        expect(Comparer.include(NumberElement(10.5), NumberElement(10.5))).to(beTrue())
        expect(Comparer.include(StringElement("Mew"), StringElement("Mew"))).to(beTrue())
        expect(Comparer.include(BooleanElement(true), BooleanElement(true))).to(beTrue())
        expect(Comparer.include(NullElement(NSNull()), NullElement(NSNull()))).to(beTrue())
        expect(Comparer.include(StringElement("Eevee"), RegexElement("E.+".regex))).to(beTrue())
        expect(Comparer.include(StringElement("Jigglypuff"), TypeElement(Type.String))).to(beTrue())
    
        expect(Comparer.include(NumberElement(151), NumberElement(1))).to(beFalse())
        expect(Comparer.include(NumberElement(10.5), NumberElement(1.5))).to(beFalse())
        expect(Comparer.include(StringElement("Mew"), StringElement("Mewtwo"))).to(beFalse())
        expect(Comparer.include(BooleanElement(true), BooleanElement(false))).to(beFalse())
        expect(Comparer.include(NullElement(NSNull()), StringElement("Hi"))).to(beFalse())
        expect(Comparer.include(StringElement("Eevee"), RegexElement("a+".regex))).to(beFalse())
        expect(Comparer.include(StringElement("Jigglypuff"), TypeElement(Type.Number))).to(beFalse())
    }
    
    func testIncludeArray() {
        let array = ArrayElement([
            NumberElement(151),
            StringElement("Mew"),
            BooleanElement(true),
            NullElement(NSNull()),
        ])
        expect(Comparer.include(array, NumberElement(151))).to(beTrue())
        expect(Comparer.include(array, StringElement("Mew"))).to(beTrue())
        expect(Comparer.include(array, BooleanElement(true))).to(beTrue())
        expect(Comparer.include(array, NullElement(NSNull()))).to(beTrue())
        expect(Comparer.include(array, RegexElement("M+".regex))).to(beTrue())
        expect(Comparer.include(array, TypeElement(Type.Number))).to(beTrue())
        expect(Comparer.include(array, TypeElement(Type.Array))).to(beTrue())
        
        expect(Comparer.include(array, NumberElement(1))).to(beFalse())
        expect(Comparer.include(array, StringElement("Mewtwo"))).to(beFalse())
        expect(Comparer.include(array, BooleanElement(false))).to(beFalse())
        expect(Comparer.include(array, StringElement("Pikachu"))).to(beFalse())
        expect(Comparer.include(array, RegexElement("P+".regex))).to(beFalse())
        expect(Comparer.include(array, TypeElement(Type.Dictionary))).to(beFalse())
    }
    
    func testIncludeDictionary() {
        let dictionary = DictionaryElement([
            "number" : NumberElement(151),
            "string" : StringElement("Mew"),
            "boolean" : BooleanElement(true),
            "null" : NullElement(NSNull()),
        ])
        expect(Comparer.include(dictionary, NumberElement(151))).to(beTrue())
        expect(Comparer.include(dictionary, StringElement("Mew"))).to(beTrue())
        expect(Comparer.include(dictionary, BooleanElement(true))).to(beTrue())
        expect(Comparer.include(dictionary, NullElement(NSNull()))).to(beTrue())
        expect(Comparer.include(dictionary, RegexElement("M+".regex))).to(beTrue())
        expect(Comparer.include(dictionary, TypeElement(Type.Number))).to(beTrue())
        
        expect(Comparer.include(dictionary, NumberElement(1))).to(beFalse())
        expect(Comparer.include(dictionary, StringElement("Mewtwo"))).to(beFalse())
        expect(Comparer.include(dictionary, BooleanElement(false))).to(beFalse())
        expect(Comparer.include(dictionary, StringElement("Pikachu"))).to(beFalse())
        expect(Comparer.include(dictionary, RegexElement("P+".regex))).to(beFalse())
        expect(Comparer.include(dictionary, TypeElement(Type.Array))).to(beFalse())
    }
    
    func testIncludeRecursiveArray() {
        expect(Comparer.include(
            ArrayElement([StringElement("Articuno"), ArrayElement([ArrayElement([ArrayElement([StringElement("Zapdos")]), StringElement("Moltres")])])]),
            StringElement("Zapdos")
        )).to(beTrue())
        expect(Comparer.include(
            ArrayElement([StringElement("Articuno"), ArrayElement([ArrayElement([ArrayElement([StringElement("Zapdos")]), StringElement("Moltres")])])]),
            StringElement("Pikachu")
        )).to(beFalse())
    }
    
    func testIncludeRecursiveDictionary() {
        expect(Comparer.include(
            DictionaryElement(["moves" : DictionaryElement(["name" : StringElement("Swift"), "type" : StringElement("normal")])]),
            StringElement("Swift")
        )).to(beTrue())
        expect(Comparer.include(
            DictionaryElement(["moves" : DictionaryElement(["name" : StringElement("Swift"), "type" : StringElement("normal")])]),
            StringElement("Tackle")
        )).to(beFalse())
    }
}
