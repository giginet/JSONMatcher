import Foundation

protocol AcceptableValueType { }
protocol RawValueType: AcceptableValueType { }

extension NSNumber: RawValueType { }
extension String: RawValueType { }
extension Bool: RawValueType { }
extension Array: AcceptableValueType { }
extension Dictionary: AcceptableValueType { }
extension NSNull: RawValueType { }
extension Regex: AcceptableValueType { }
extension Type: AcceptableValueType { }

struct JSONElement {
    var value: AcceptableValueType
    
    init(_ value: RawValueType) {
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

extension JSONElement {
    init(_ array: [AcceptableValueType]) {
        let recursiveArray = JSONElement.makeJSONElementsArrayRecursively(array)
        self.value = recursiveArray
    }
    
    private static func makeJSONElementsArrayRecursively(elements: [Element]) -> [Element] {
        var elementArray: [Element] = []
        for rawElement: Element in elements {
            if let array = rawElement as? [Element] {
                let array = self.makeJSONElementsArrayRecursively(array)
                elementArray.append(array)
            } else {
                elementArray.append(rawElement)
            }
        }
        return elementArray
    }
}

extension JSONElement: ArrayLiteralConvertible {
    typealias Element = AcceptableValueType
    
    init(arrayLiteral elements: Element...) {
        let recursiveArray = JSONElement.makeJSONElementsArrayRecursively(Array(arrayLiteral: elements))
        self.value = recursiveArray
    }
}

extension JSONElement {
    init(_ dictionary: [String: AcceptableValueType]) {
        let recursiveDictionary = JSONElement.makeJSONElementsDictionaryRecursively(dictionary)
        self.value = recursiveDictionary
    }
    
    private static func makeJSONElementsDictionaryRecursively(elements: [Key: Value]) -> [Key: Value] {
        var elementDictionary: [Key: Value] = [:]
        for (rawKey, rawElement): (Key, Value) in elements {
            if let dictionary = rawElement as? [Key: Value] {
                let dictionary = makeJSONElementsDictionaryRecursively(dictionary)
                elementDictionary[rawKey] = dictionary
            } else {
                elementDictionary[rawKey] = rawElement
            }
        }
        return elementDictionary
    }
}

extension JSONElement: DictionaryLiteralConvertible {
    typealias Key = String
    typealias Value = AcceptableValueType
    
    init(dictionaryLiteral elements: (Key, Value)...) {
        var dictionary: [Key: Value] = [:]
        for (rawKey, rawElement) in elements {
            dictionary[rawKey] = rawElement
        }
        let recursiveDictionary = JSONElement.makeJSONElementsDictionaryRecursively(dictionary)
        self.value = recursiveDictionary
    }
}
