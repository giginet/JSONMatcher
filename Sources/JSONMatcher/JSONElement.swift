import Foundation

protocol AbstractJSONElementType {
    
}

protocol BaseJSONElementType: AbstractJSONElementType { 
    associatedtype T;
    var value: T { get }
}

struct GenericJSONElement<T>: BaseJSONElementType {
    let value: T

    init(_ value: T) {
        self.value = value
    }
}

struct NumberElement: BaseJSONElementType {
    let value: NSNumber
    
    init(_ number: NSNumber) {
        self.value = number
    }
}

struct StringElement: BaseJSONElementType {
    let value: String
    
    init(_ string: String) {
        self.value = string
    }
}

struct BoolElement: BaseJSONElementType {
    let value: Bool
    
    init(_ bool: Bool) {
        self.value = bool
    }
}

struct NullElement: BaseJSONElementType {
    let value: NSNull
    
    init(_ null: NSNull) {
        self.value = null
    }
}

struct ArrayElement: BaseJSONElementType {
    let value: [AbstractJSONElementType]
    
    init(_ array: [AbstractJSONElementType]) {
        self.value = array
    }
}

struct DictionaryElement: BaseJSONElementType {
    let value: [String: AbstractJSONElementType]
    
    init(_ dictionary: [String: AbstractJSONElementType]) {
        self.value = dictionary
    }
}