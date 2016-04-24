//: Playground - noun: a place where people can play

import UIKit
import SwiftyJSON
@testable import JSONMatcher

let data = "{".dataUsingEncoding(NSUTF8StringEncoding)!
let json = JSON(data: data)
json.isEmpty
json.isExists()
json.null

let ac: AnyObject.Type = UIView.self
"hoge".dynamicType

NSStringFromClass(ac)

ObjectIdentifier(ac) == ObjectIdentifier("".dynamicType)

let string: JSONElement = "foo"
let element = JSONElement("foo")

let elementArray: JSONElement = [
    "foo",
    "bar",
    ["hoge", 10, 30],
    [
        "key" : "value",
        "tags" : ["a", "b", "c"]
    ],
]

/*let elementDictionary = [
    "piyo" : RegexElement(".+"),
    "type" : TypeElement(String.self)
]*/

Comparer.compare(["foo", 10, 20], ["foo", 10, 20])

["a", 10].dynamicType

protocol AnyProtocol { }

0x10 == 16

[10, "^foo".regex, "bar", "[a-z]+"]

protocol Test { }
extension String: Test { }
extension Int: Test { }
extension NSObject: Test { }

let stringArray: [String] = ["a", "b", "c"]
"a" is Test
//stringArray is [Test]

func compareArray<T: CollectionType where T.Generator.Element == Test>(lhs: T) -> Bool {
    return true
}

func compareDictionary<T: CollectionType where T.Generator.Element == (String, Test)>(lhs: T) {
}

let list: [Test] = [1, 2, "aaa"]
compareArray(list)

func testFunction(lhs: AcceptableValueType, _ rhs: AcceptableValueType) -> Bool {
    switch (lhs, rhs) {
    case let (number as String, expectedNumber as String):
        return number == expectedNumber
    default:
        return false
    }
    return false
}
testFunction("a", "a")