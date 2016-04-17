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

struct Element<T> {
    let type: Type
    let value: T?
    
    init(_ value: T?) {
        switch value  {
        case is Double, is Int, is Float:
            self.type = .Number
        case is String:
            self.type = .String
        case is Bool:
            self.type = .Bool
        case is [Any], is [NSObject], is NSArray:
            self.type = .Array
        case is [String: Any], is [String: NSObject], is NSDictionary:
            self.type = .Dictionary
        case nil:
            self.type = .Null
        default:
            self.type = .Unknown
        }
        self.value = value
    }
    
    func match(regex: Regex) -> Bool {
        guard self.type == .String else {
            return false
        }
        
        return regex.match(self.value as! String)
    }
}

func ==<T: Comparable>(lhs: Element<T>, rhs: Element<T>) -> Bool {
    guard lhs.type == rhs.type else {
        return false
    }
    return lhs.value == rhs.value
}
