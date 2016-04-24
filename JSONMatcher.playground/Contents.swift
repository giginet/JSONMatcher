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

let a = Numeric(10.0)
let b = Numeric(10)

print(a == b)

func test<T, U>(a: T, b: U) -> Bool {
    if let a = a as? Numeric, let b = b as? Numeric {
        return a == b
    }
    return false
}

["a", 10].dynamicType

protocol AnyProtocol { }

0x10 == 16