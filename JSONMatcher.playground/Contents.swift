//: Playground - noun: a place where people can play

import UIKit
@testable import JSONMatcher

var str = "Hello, playground"

let type0: Any.Type = Int.self
let type1: Any.Type = String.self

let v = [1, 2, 3, 4, 5, "hoge"]
v.dynamicType

func isArray(obj: Any) -> Bool {
    switch v {
    case is [Any], is [NSObject]:
        return true
    default:
        return false
    }
}

isArray(v)

[1, 2, 3, 4, 5].dynamicType
[1, 2, 3, 4, 5] is Array<Any>
[1, 2, 3, 4, 5] is [Any]

["a": "hoge"].dynamicType
["a": "hoge"] is [String: Any]
["a": "hoge"] is NSDictionary