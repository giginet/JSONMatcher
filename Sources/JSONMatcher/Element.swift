import Foundation

protocol AcceptableValueType { }
extension NSNumber: AcceptableValueType { }
extension String: AcceptableValueType { }
extension Bool: AcceptableValueType { }
extension Array: AcceptableValueType { }
extension Dictionary: AcceptableValueType { }
extension NSNull: AcceptableValueType { }
extension Regex: AcceptableValueType { }
extension Type: AcceptableValueType { }

struct JSONElement: AcceptableValueType {
    var value: AcceptableValueType
    
    init(_ value: AcceptableValueType) {
        self.value = value
    }
}

extension JSONElement: IntegerLiteralConvertible {
    init(integerLiteral value: IntegerLiteralType) {
        self.value = NSNumber(integer: value)
    }
}

extension JSONElement: FloatLiteralConvertible {
    init(floatLiteral value: FloatLiteralType) {
        self.value = NSNumber(double: value)
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
        self.value = NSNull()
    }
}

extension JSONElement: ArrayLiteralConvertible {
    typealias Element = AcceptableValueType
    
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
    typealias Value = AcceptableValueType
    
    init(dictionaryLiteral elements: (Key, Value)...) {
        var elementDictionary: [Key: JSONElement] = [:]
        for (rawKey, rawElement): (Key, Value) in elements {
            let element: JSONElement = JSONElement(rawElement)
            elementDictionary[rawKey] = element
        }
        self.value = elementDictionary
    }
}
