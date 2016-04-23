import Foundation

enum Type: Int {
    case Number
    case String
    case Boolean
    case Array
    case Dictionary
    case Null
    case Unknown
    case Regex
    case Class
}

protocol ElementType: Equatable {
    associatedtype T
    var value: T { get set }
    var type: Type { get }
}

struct JSONElement: ElementType {
    typealias T = Any
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
    
    var type: Type {
        switch self.value {
        case is Int, is UInt, is Float, is Double:
            return .Number
        case is String:
            return .String
        case is Bool:
            return .Boolean
        case is [Any]:
            return .Array
        case is [String: Any]:
            return .Dictionary
        case is NSNull:
            return .Null
        default:
            return .Unknown
        }
    }
    
}

func ==(lhs: JSONElement, rhs: JSONElement) -> Bool {
    guard lhs.type == rhs.type else {
        return false
    }
    
    if let l = lhs.value as? Double, let r = rhs.value as? Double {
        return l == r
    }
    
    if let l = lhs.value as? String, let r = rhs.value as? String {
        return l == r
    }
    
    if let l = lhs.value as? Bool, let r = rhs.value as? Bool {
        return l == r
    }
    
    if let l = lhs.value as? NSNull, let r = rhs.value as? NSNull {
        return l == r
    }
    
    if let l = lhs.value as? [JSONElement], let r = rhs.value as? [JSONElement] {
        return l == r
    }
    
    if let l = lhs.value as? [String: JSONElement], let r = rhs.value as? [String: JSONElement] {
        return l == r
    }
    
    return false
}

extension JSONElement: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    typealias UnicodeScalarLiteralType = StringLiteralType
    
    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.value = "\(value)"
    }
    
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.value = value
    }
    
    init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
}

extension JSONElement: BooleanLiteralConvertible {
    init(booleanLiteral value: BooleanLiteralType) {
        self.value = value
    }
}

extension JSONElement: NilLiteralConvertible {
    init(nilLiteral value: ()) {
        self.value = value
    }
}

extension JSONElement: ArrayLiteralConvertible {
    typealias Element = AnyObject
    
    init(arrayLiteral elements: Element...) {
        var elementArray: [JSONElement] = []
        for rawElement: Element in elements {
            let element: JSONElement = JSONElement(rawElement)
            elementArray.append(element)
        }
        self.value = elementArray
    }
}

extension JSONElement: DictionaryLiteralConvertible {
    typealias Key = String
    typealias Value = AnyObject
    
    init(dictionaryLiteral elements: (Key, Value)...) {
        var elementDictionary: [Key: JSONElement] = [:]
        for (rawKey, rawElement): (Key, Value) in elements {
            let element: JSONElement = JSONElement(rawElement)
            elementDictionary[rawKey] = element
        }
        self.value = elementDictionary
    }
}

class RegexElement: ElementType {
    typealias T = Regex
    var value: T
    let type: Type = .Regex
    
    init(_ value: T) {
        self.value = value
    }
    
    init(_ pattern: String) {
        self.value = Regex(pattern)
    }
}

func ==(lhs: RegexElement, rhs: RegexElement) -> Bool {
    return false
}

class TypeElement: ElementType {
    typealias T = Type
    var value: T
    let type: Type = .Class
    
    init(_ value: T) {
        self.value = value
    }
    
    func isTypeOf(obj: Any) -> Bool {
        let element = JSONElement(obj)
        return element.type == self.value
    }
}

func ==(lhs: TypeElement, rhs: TypeElement) -> Bool {
    return false
}
