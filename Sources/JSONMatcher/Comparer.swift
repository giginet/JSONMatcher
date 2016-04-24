import Foundation

struct  Comparer {
    static func compare(lhs: JSONElement, _ rhs: JSONElement) -> Bool {
        return self.compareElements(lhs, rhs)
    }
    
    private static func compareElements(lhs: JSONElement, _ rhs: JSONElement) -> Bool {
        switch rhs.value {
        case let expectedNumber as NSNumber:
            guard let number = lhs.value as? NSNumber else {
                return false
            }
            return number == expectedNumber
        case let expectedString as String:
            guard let string = lhs.value as? String else {
                return false
            }
            return string == expectedString
        case let expectedBool as Bool:
            guard let bool = lhs.value as? Bool else {
                return false
            }
            return bool == expectedBool
        case let expectedNull as NSNull:
            guard let null = lhs.value as? NSNull else {
                return false
            }
            return null == expectedNull
        case let expectedArray as [JSONElement]:
            guard let array = lhs.value as? [JSONElement] else {
                return false
            }
            
            guard array.count == expectedArray.count else {
                return false
            }
            
            for (element0, element1) in zip(array, expectedArray) {
                if (!compareElements(element0, element1)) {
                    return false
                }
            }
        case let expectedDictionary as [String: JSONElement]:
            guard let dictionary = lhs.value as? [String: JSONElement] else {
                return false
            }
            
            guard dictionary.count == expectedDictionary.count else {
                return false
            }
            
            for ((key0, value0), (key1, value1)) in zip(dictionary, expectedDictionary) {
                if (key0 != key1 || !compareElements(value0, value1)) {
                    return false
                }
            }
        case let expectedElement as JSONElement:
            guard let element = lhs.value as? JSONElement else {
                return false
            }
            return compareElements(element, expectedElement)
        case let regex as Regex:
            guard let string = lhs.value as? String else {
                return false
            }
            return regex.match(string)
        case let type as Type:
            return type.isKindOf(lhs.value)
        default:
            return false
        }
        
        return true
    }
}