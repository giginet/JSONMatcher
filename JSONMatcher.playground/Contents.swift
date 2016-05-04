//: Playground - noun: a place where people can play

import UIKit
@testable import JSONMatcher

class Model { }

let array0 = [
    42,
    10.5,
    "🍺",
    true,
    NSNull(),
    Model(),
    ".+".regex,
    //Type.Number,
    ["cupcake", "donuts", "eclair", "froyo"],
    ["T" : "Tozai", "Z" : "Hanzomon", "H" : "Hibiya"],
]

array0.dynamicType

let builder = Builder()
builder.buildJSONElement(array0)