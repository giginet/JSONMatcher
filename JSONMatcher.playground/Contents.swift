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

protocol Type {
}
