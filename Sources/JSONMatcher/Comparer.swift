import Foundation


struct  Comparer {
    static func compare<T: ElementType, U: ElementType>(lhs: T, _ rhs: U) -> Bool {
        return self.compareRawValueType(lhs, rhs)
    }
    
    private static func compareArray(lhs: ArrayElement, _ rhs: ArrayElement) -> Bool {
        guard lhs.value.count == rhs.value.count else {
            return false
        }
        
        for (element0, element1) in zip(lhs.value, rhs.value) {
            if (!compareRawValueType(element0, element1)) {
                return false
            }
        }
        return true
    }
    
    private static func compareDictionary(lhs: DictionaryElement, _ rhs: DictionaryElement) -> Bool {
        guard lhs.value.count == rhs.value.count else {
            return false
        }
        
        for ((k0, v0), (k1, v1)) in zip(lhs.value, rhs.value) {
            if (k0 != k1 || !compareRawValueType(v0, v1)) {
                return false
            }
        }
        return true
    }
    
    private static func compareRawValueType<T, U>(lhs: T, _ rhs: U) -> Bool {
        switch (lhs, rhs) {
        case let (number as NumberElement, expectedNumber as NumberElement):
            return number.value == expectedNumber.value
        case let (string as StringElement, expectedString as StringElement):
            return string.value == expectedString.value
        case let (bool as BooleanElement, expectedBool as BooleanElement):
            return bool.value == expectedBool.value
        case let (null as NullElement, expectedNull as NullElement):
            return null.value == expectedNull.value
        case let (array as ArrayElement, expectedArray as ArrayElement):
            return compareArray(array, expectedArray)
        case let (dictionary as DictionaryElement, expectedDictionary as DictionaryElement):
            return compareDictionary(dictionary, expectedDictionary)
        case let (string as StringElement, regex as RegexElement):
            return regex.value.match(string.value)
        case let (lhs as NumberElement, rhs as TypeElement):
            return lhs.type == rhs.value
        case let (lhs as StringElement, rhs as TypeElement):
            return lhs.type == rhs.value
        case let (lhs as BooleanElement, rhs as TypeElement):
            return lhs.type == rhs.value
        case let (lhs as ArrayElement, rhs as TypeElement):
            return lhs.type == rhs.value
        case let (lhs as DictionaryElement, rhs as TypeElement):
            return lhs.type == rhs.value
        case let (lhs as NullElement, rhs as TypeElement):
            return lhs.type == rhs.value
        default:
            return false
        }
    }
}