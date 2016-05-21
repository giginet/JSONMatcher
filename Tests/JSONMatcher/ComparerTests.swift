import XCTest
import Nimble
@testable import JSONMatcher

class CompareTestCase: XCTestCase {
    var comparer: Comparer!

    override func setUp() {
        super.setUp()
        self.comparer = Comparer()
    }

    func testSimpleStringElement() {
        expect(self.comparer.compare(StringElement("foo"),
            StringElement("foo"))).to(beTrue())
        expect(self.comparer.compare(StringElement("foo"),
            StringElement("bar"))).to(beFalse())
    }

    func testSimpleNumberElement() {
        expect(self.comparer.compare(NumberElement(10),
            NumberElement(10))).to(beTrue())
        expect(self.comparer.compare(NumberElement(10),
            NumberElement(10.0))).to(beTrue())
        expect(self.comparer.compare(NumberElement(16),
            NumberElement(0x10))).to(beTrue())
        expect(self.comparer.compare(NumberElement(30),
            NumberElement(30.0000001))).to(beFalse())
    }

    func testSimpleBoolElement() {
        expect(self.comparer.compare(BooleanElement(true),
            BooleanElement(true))).to(beTrue())
        expect(self.comparer.compare(BooleanElement(false),
            BooleanElement(true))).to(beFalse())
    }

    func testSimpleNilElement() {
        expect(self.comparer.compare(NullElement(), NullElement())).to(beTrue())
    }

    func testSimpleRegex() {
        expect(self.comparer.compare(StringElement("foo"),
            RegexElement(".+".regex))).to(beTrue())
        expect(self.comparer.compare(StringElement("10"),
            RegexElement("[0-9]{2}".regex))).to(beTrue())
        expect(self.comparer.compare(StringElement("10"),
            RegexElement(try! NSRegularExpression(pattern: "[0-9]+", options: [])))).to(beTrue())
        expect(self.comparer.compare(NumberElement(10),
            RegexElement("10".regex))).to(beFalse())
        expect(self.comparer.compare(BooleanElement(false),
            RegexElement(".+".regex))).to(beFalse())
    }

    func testSimpleType() {
        expect(self.comparer.compare(NumberElement(42),
            TypeElement(Type.Number))).to(beTrue())
        expect(self.comparer.compare(NumberElement(42.195),
            TypeElement(Type.Number))).to(beTrue())
        expect(self.comparer.compare(StringElement("sushi"),
            TypeElement(Type.Number))).to(beFalse())
        expect(self.comparer.compare(StringElement("🍣"),
            TypeElement(Type.String))).to(beTrue())
        expect(self.comparer.compare(BooleanElement(true),
            TypeElement(Type.Boolean))).to(beTrue())
        expect(self.comparer.compare(BooleanElement(false),
            TypeElement(Type.Boolean))).to(beTrue())
        expect(self.comparer.compare(NullElement(NSNull()),
            TypeElement(Type.Null))).to(beTrue())
        expect(self.comparer.compare(ArrayElement([
            StringElement("a"),
            StringElement("b"),
            StringElement("c"), ]
        ), TypeElement(Type.Array))).to(beTrue())
        expect(self.comparer.compare(DictionaryElement([
            "a" : StringElement("a"),
            "b" : StringElement("b"),
            "c" : StringElement("c"), ]
        ), TypeElement(Type.Dictionary))).to(beTrue())

    }

    func testSimpleArray() {
        expect(self.comparer.compare(
            ArrayElement([NumberElement(10), NumberElement(20)]),
            ArrayElement([NumberElement(10), NumberElement(20)]))
        ).to(beTrue())
        expect(self.comparer.compare(
            ArrayElement([NumberElement(10), StringElement("foo"), BooleanElement(true)]),
            ArrayElement([NumberElement(10), StringElement("foo"), BooleanElement(true)]))
        ).to(beTrue())
        expect(self.comparer.compare(
            ArrayElement([NumberElement(10), NumberElement(20)]),
            ArrayElement([NumberElement(10), NumberElement(20), NumberElement(30)]))
        ).to(beFalse())
        expect(self.comparer.compare(
            ArrayElement([NumberElement(10), NumberElement(20)]),
            ArrayElement([StringElement("10"), StringElement("20")]))
        ).to(beFalse())
    }

    func testSimpleDictionary() {
        expect(self.comparer.compare(
            DictionaryElement(["name" : StringElement("Jigglypuff"), "no": NumberElement(39)]),
            DictionaryElement(["name" : StringElement("Jigglypuff"), "no": NumberElement(39)]))
        ).to(beTrue())
    }

    func testArrayWithRegex() {
        expect(self.comparer.compare(
            ArrayElement([NumberElement(10), StringElement("foo"), StringElement("bar"), StringElement("apple")]),
            ArrayElement([
                NumberElement(10),
                RegexElement("f+".regex),
                StringElement("bar"),
                RegexElement("[a-z]+".regex)
            ]))
        ).to(beTrue())
    }

    func testArrayWithType() {
        expect(self.comparer.compare(
            ArrayElement([NumberElement(10), StringElement("foo"), StringElement("bar")]),
            ArrayElement([TypeElement(Type.Number), TypeElement(Type.String), StringElement("bar")]))
        ).to(beTrue())
    }

    func testRecursiveArray() {
        expect(self.comparer.compare(
            ArrayElement([
                StringElement("Articuno"),
                ArrayElement([ArrayElement([ArrayElement([StringElement("Zapdos")]), StringElement("Moltres")])])]),
            ArrayElement([
                TypeElement(Type.String),
                ArrayElement([ArrayElement([
                    ArrayElement([StringElement("Zapdos")]),
                    RegexElement("[A-Z][a-z].+".regex)
                ])])]))
        ).to(beTrue())
        expect(self.comparer.compare(
            ArrayElement([
                StringElement("Articuno"),
                ArrayElement([ArrayElement([ArrayElement([
                    StringElement("Zapdos")
                ]), StringElement("Moltres")])])
            ]),
            ArrayElement([
                TypeElement(Type.String),
                ArrayElement([ArrayElement([ArrayElement([
                    StringElement("Jigglypuff")
                ]), RegexElement("[A-Z][a-z].+".regex)])])
            ]))
        ).to(beFalse())
    }

    func testRecursiveDictionary() {
        expect(self.comparer.compare(
            DictionaryElement(["moves" : DictionaryElement([
                "name" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]),
            DictionaryElement(["moves" : DictionaryElement([
                "name" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]))
        ).to(beTrue())
        expect(self.comparer.compare(
            DictionaryElement(["moves" : DictionaryElement([
                "name" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]),
            DictionaryElement(["moves" : DictionaryElement([
                "type" : StringElement("Swift"),
                "name" : StringElement("normal")
            ])]))
        ).to(beFalse())
        expect(self.comparer.compare(
            DictionaryElement(["moves" : DictionaryElement([
                "name" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]),
            DictionaryElement(["moves" : DictionaryElement([
                "invalid" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]))
        ).to(beFalse())
    }

    func testComplexObject() {
        expect(self.comparer.compare(DictionaryElement([
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
    var comparer: Comparer!

    override func setUp() {
        super.setUp()
        self.comparer = Comparer()
    }

    func testIncludeExactMatch() {
        expect(self.comparer.include(NumberElement(151), NumberElement(151))).to(beTrue())
        expect(self.comparer.include(NumberElement(10.5), NumberElement(10.5))).to(beTrue())
        expect(self.comparer.include(StringElement("Mew"), StringElement("Mew"))).to(beTrue())
        expect(self.comparer.include(BooleanElement(true), BooleanElement(true))).to(beTrue())
        expect(self.comparer.include(NullElement(NSNull()), NullElement(NSNull()))).to(beTrue())
        expect(self.comparer.include(StringElement("Eevee"), RegexElement("E.+".regex))).to(beTrue())
        expect(self.comparer.include(StringElement("Jigglypuff"), TypeElement(Type.String))).to(beTrue())

        expect(self.comparer.include(NumberElement(151), NumberElement(1))).to(beFalse())
        expect(self.comparer.include(NumberElement(10.5), NumberElement(1.5))).to(beFalse())
        expect(self.comparer.include(StringElement("Mew"), StringElement("Mewtwo"))).to(beFalse())
        expect(self.comparer.include(BooleanElement(true), BooleanElement(false))).to(beFalse())
        expect(self.comparer.include(NullElement(NSNull()), StringElement("Hi"))).to(beFalse())
        expect(self.comparer.include(StringElement("Eevee"), RegexElement("a+".regex))).to(beFalse())
        expect(self.comparer.include(StringElement("Jigglypuff"), TypeElement(Type.Number))).to(beFalse())
    }

    func testIncludeArray() {
        let array = ArrayElement([
            NumberElement(151),
            StringElement("Mew"),
            BooleanElement(true),
            NullElement(NSNull()),
        ])
        expect(self.comparer.include(array, NumberElement(151))).to(beTrue())
        expect(self.comparer.include(array, StringElement("Mew"))).to(beTrue())
        expect(self.comparer.include(array, BooleanElement(true))).to(beTrue())
        expect(self.comparer.include(array, NullElement(NSNull()))).to(beTrue())
        expect(self.comparer.include(array, RegexElement("M+".regex))).to(beTrue())
        expect(self.comparer.include(array, TypeElement(Type.Number))).to(beTrue())
        expect(self.comparer.include(array, TypeElement(Type.Array))).to(beTrue())

        expect(self.comparer.include(array, NumberElement(1))).to(beFalse())
        expect(self.comparer.include(array, StringElement("Mewtwo"))).to(beFalse())
        expect(self.comparer.include(array, BooleanElement(false))).to(beFalse())
        expect(self.comparer.include(array, StringElement("Pikachu"))).to(beFalse())
        expect(self.comparer.include(array, RegexElement("P+".regex))).to(beFalse())
        expect(self.comparer.include(array, TypeElement(Type.Dictionary))).to(beFalse())
    }

    func testIncludeDictionary() {
        let dictionary = DictionaryElement([
            "number" : NumberElement(151),
            "string" : StringElement("Mew"),
            "boolean" : BooleanElement(true),
            "null" : NullElement(NSNull()),
        ])
        expect(self.comparer.include(dictionary, NumberElement(151))).to(beTrue())
        expect(self.comparer.include(dictionary, StringElement("Mew"))).to(beTrue())
        expect(self.comparer.include(dictionary, BooleanElement(true))).to(beTrue())
        expect(self.comparer.include(dictionary, NullElement(NSNull()))).to(beTrue())
        expect(self.comparer.include(dictionary, RegexElement("M+".regex))).to(beTrue())
        expect(self.comparer.include(dictionary, TypeElement(Type.Number))).to(beTrue())

        expect(self.comparer.include(dictionary, NumberElement(1))).to(beFalse())
        expect(self.comparer.include(dictionary, StringElement("Mewtwo"))).to(beFalse())
        expect(self.comparer.include(dictionary, BooleanElement(false))).to(beFalse())
        expect(self.comparer.include(dictionary, StringElement("Pikachu"))).to(beFalse())
        expect(self.comparer.include(dictionary, RegexElement("P+".regex))).to(beFalse())
        expect(self.comparer.include(dictionary, TypeElement(Type.Array))).to(beFalse())
    }

    func testIncludeRecursiveArray() {
        expect(self.comparer.include(
            ArrayElement([StringElement("Articuno"), ArrayElement([
                ArrayElement([
                    ArrayElement([StringElement("Zapdos")]),
                    StringElement("Moltres")])])]),
            StringElement("Zapdos")
        )).to(beTrue())
        expect(self.comparer.include(
            ArrayElement([
                StringElement("Articuno"),
                ArrayElement([ArrayElement([
                    ArrayElement([StringElement("Zapdos")]),
                    StringElement("Moltres")
                ])])]),
            StringElement("Pikachu")
        )).to(beFalse())
    }

    func testIncludeRecursiveDictionary() {
        expect(self.comparer.include(
            DictionaryElement(["moves" : DictionaryElement([
                "name" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]),
            StringElement("Swift")
        )).to(beTrue())
        expect(self.comparer.include(
            DictionaryElement(["moves" : DictionaryElement([
                "name" : StringElement("Swift"),
                "type" : StringElement("normal")
            ])]),
            StringElement("Tackle")
        )).to(beFalse())
    }
}
