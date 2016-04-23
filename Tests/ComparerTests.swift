import XCTest
import Nimble
import SwiftyJSON
@testable import JSONMatcher

class ComparerTestCase: XCTestCase {
    func testSimpleStringElement() {
        expect(Comparer(json: JSON("foo"), expected: "foo").compare()).to(beTrue())
        expect(Comparer(json: JSON("foo"), expected: "bar").compare()).to(beFalse())
    }
    
    func testSimpleNumberElement() {
        expect(Comparer(json: JSON(10), expected: 10).compare()).to(beTrue())
        expect(Comparer(json: JSON(100), expected: 100.000).compare()).to(beTrue())
        expect(Comparer(json: JSON(10.1), expected: 30).compare()).to(beFalse())
        
    }
    
    func testSimpleBoolElement() {
        expect(Comparer(json: JSON(true), expected: true).compare()).to(beTrue())
        expect(Comparer(json: JSON(true), expected: false).compare()).to(beFalse())
    }
    
    func testSimpleRegex() {
        expect(Comparer(json: JSON("foo"), expected: Regex(".+")).compare()).to(beTrue())
        expect(Comparer(json: JSON("10"), expected: Regex("[0-9]{2}")).compare()).to(beTrue())
        expect(Comparer(json: JSON(10), expected: Regex("10")).compare()).to(beFalse())
        expect(Comparer(json: JSON(false), expected: Regex(".+")).compare()).to(beFalse())
    }
    
    func testSimpleArray() {
        expect(Comparer(json: JSON([10, 20]), expected: [10, 20]).compare()).to(beTrue())
        expect(Comparer(json: JSON([10, "foo", true]), expected: [10, "foo", true]).compare()).to(beTrue())
        expect(Comparer(json: JSON([10, 20, 50]), expected: [10, 30, 50]).compare()).to(beFalse())
    }
    
    func testSimpleDictionary() {
        expect(Comparer(json: JSON(["name": "bob", "age": 30]), expected: ["name": "bob", "age": 30]).compare()).to(beTrue())
    }
    
    func testArrayWithRegex() {
        expect(Comparer(json: JSON([10, "foo", "bar", "apple"]), expected: [10, Regex("^fo+$"), "bar", Regex("[a-z]+")]).compare()).to(beTrue())
    }
    
    func testComplexObject() {
        expect(Comparer(json: JSON([
                "title" : "Introduce new feature!",
                "body" : "New feature is now available. Please check it out",
                "url" : "https://example.com/articles/305/",
                "published_at" : "2016-04-23T15:50:00+09:00",
                "published" : true,
                "author" : [
                    "name" : "alice",
                    "age" : 30
                ],
                "tags" : ["new feature", "update", "diary"]
                ]),
            expected: [
                "title" : "Introduce new feature!",
                "body" : "New feature is now available. Please check it out",
                "url" : "https://example.com/articles/305/",
                "published_at" : Regex("\\d{4}\\-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\+\\d{2}:0{2}"),
                "published" : true,
                "author" : [
                    "name" : "alice",
                    "age" : 30
                ],
                "tags" : ["new feature", "update", "diary"]
                
            ]).compare()).to(beTrue())
    }

}
