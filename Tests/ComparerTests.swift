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
    
    func testComplexObject() {
        expect(Comparer.compare(DictionaryElement([
            "title" : StringElement("Introduce new feature!"),
            "body" : StringElement("New feature is now available. Please check it out"),
            "url" : StringElement("https://example.com/articles/305/"),
            "published_at" : StringElement("2016-04-23T15:50:00+09:00"),
            "published" : BooleanElement(true),
            "author" : DictionaryElement([
             "name" : StringElement("alice"),
             "age" : NumberElement(30)
            ]),
            "tags" : ArrayElement([StringElement("new feature"), StringElement("update"), StringElement("diary")])
        ]), DictionaryElement([
            "title" : StringElement("Introduce new feature!"),
            "body" : StringElement("New feature is now available. Please check it out"),
            "url" : StringElement("https://example.com/articles/305/"),
            "published_at" : RegexElement("\\d{4}\\-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\+\\d{2}:0{2}".regex),
            "published" : BooleanElement(true),
            "author" : DictionaryElement([
                "name" : StringElement("alice"),
                "age" : NumberElement(30)
            ]),
            "tags" : ArrayElement([StringElement("new feature"), StringElement("update"), StringElement("diary")])
        ]))).to(beTrue())
    }

}
