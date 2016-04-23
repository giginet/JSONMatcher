import Foundation

protocol ElementType {
    associatedtype T
    var value: T { get set }
}

/*struct NumberElement: ElementType {
    let value: Double
}

struct StringElement: ElementType {
    let value: String
}*/

struct JSONElement: ElementType {
    typealias T = Any
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
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
    typealias T = String
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}

class TypeElement: ElementType {
    typealias T = Any.Type
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}