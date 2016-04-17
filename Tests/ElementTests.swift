import XCTest
import Nimble
@testable import JSONMatcher

class ElementTestCase: XCTestCase {
    func testTypeNumber() {
        expect(Element(0).type).to(equal(Type.Number))
        expect(Element(1).type).to(equal(Type.Number))
        expect(Element(1.1).type).to(equal(Type.Number))
        expect(Element(0x1111).type).to(equal(Type.Number))
        expect(Element(1.5).type).to(equal(Type.Number))
        expect(Element("1.1111").type).toNot(equal(Type.Number))
        expect(Element(NSNumber(integer: 32)).type).to(equal(Type.Number))
        expect(Element(NSNumber(float: 12.35)).type).to(equal(Type.Number))
        expect(Element(NSNumber(double: 12.35)).type).to(equal(Type.Number))
        expect(Element(NSNumber(bool: true)).type).to(equal(Type.Number))
    }
    
    func testTypeString() {
        expect(Element("").type).to(equal(Type.String))
        expect(Element("hello").type).to(equal(Type.String))
        expect(Element("🍣").type).to(equal(Type.String))
    }
    
    func testTypeBool() {
        expect(Element(true).type).to(equal(Type.Bool))
        expect(Element(false).type).to(equal(Type.Bool))
        expect(Element(NSNumber(bool: true)).type).toNot(equal(Type.Bool))
    }
    
    func testTypeArray() {
        expect(Element([]).type).to(equal(Type.Array))
        expect(Element([1, 2, 3, 4, 5]).type).to(equal(Type.Array))
        expect(Element(["a", "b", 6, 3.44]).type).to(equal(Type.Array))
    }
    
    func testTypeDictionary() {
        expect(Element(["a": "hoge"]).type).to(equal(Type.Dictionary))
        expect(Element([1: "hoge"]).type).to(equal(Type.Dictionary))
        expect(Element(["hoge": ["fuga": "piyo"]]).type).to(equal(Type.Dictionary))
    }
    
    func testTypeNull() {
        expect(Element<String?>(nil).type).to(equal(Type.Null))
        expect(Element(NSNull()).type).toNot(equal(Type.Null))
    }
    
    func testTypeUnknown() {
        expect(Element(UIView()).type).to(equal(Type.Unknown))
    }
    
    func testMatch() {
        expect(Element("foobar").match(Regex("oo"))).to(beTrue())
        expect(Element("foobar").match(Regex("^foo"))).to(beTrue())
        expect(Element("foobar").match(Regex("piyo"))).to(beFalse())
        expect(Element(1).match(Regex("1"))).to(beFalse())
    }
}
