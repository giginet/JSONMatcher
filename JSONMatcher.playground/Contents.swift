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