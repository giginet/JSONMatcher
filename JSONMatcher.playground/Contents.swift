//: Playground - noun: a place where people can play

import UIKit
import SwiftyJSON
@testable import JSONMatcher

let builder = Builder()
builder.buildJSONElement(["a", "b"])
builder.buildJSONElement(1)
builder.buildJSONElement(true)
let arrayElement: ArrayElement = builder.buildJSONElement(["a", "b", ["a", "b", ["a", "b"]]]) as! ArrayElement
arrayElement.value[0]
arrayElement.value[1]
let innerArrayElement: ArrayElement = arrayElement.value[2] as! ArrayElement
innerArrayElement.value[0]
innerArrayElement.value[1]
innerArrayElement.value[2]

let dictionaryElement = builder.buildJSONElement(["name": "hoge", "items": ["a", "b", 10, 100, true]]) as! DictionaryElement
dictionaryElement.value["name"]
dictionaryElement.value["items"]
