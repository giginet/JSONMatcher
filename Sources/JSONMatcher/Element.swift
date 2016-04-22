import Foundation

enum Type: Int {
    case Number
    case String
    case Bool
    case Array
    case Dictionary
    case Null
    case Unknown
}

protocol ElementType {
    associatedtype T
    var type: Type { get }
}

struct Element<T>: ElementType {
    typealias T = Any
    let value: T
    
    init(_ value: T) {
        self.value = value
    }

    var type: Type {
        return .Unknown
    }
}

extension Element where T: NSNumber {
    var type: Type {
        return .Number
    }
}

/*
extension Element where T: String {
    var type: Type {
        return .String
    }
    
    func match(regex: Regex) -> Bool {
        guard self.type == .String else {
            return false
        }
        
        return regex.match(self.value as! String)
    }
}
*/

/*
extension Element where T == Bool? {
    var type: Type {
        return .Bool
    }
}*/

extension Element where T: NSArray {
    var type: Type {
        return .Array
    }
}

extension Element where T: NSDictionary {
    var type: Type {
        return .Dictionary
    }
}

extension Element where T: NSNull {
    var type: Type {
        return .Null
    }
}
/*
func ==<T: Comparable>(lhs: Element<T>, rhs: Element<T>) -> Bool {
    guard lhs.type == rhs.type else {
        return false
    }
    return lhs.value == rhs.value
}*/
