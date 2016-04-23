import Foundation

struct  Comparer {
    static func compare(lhs: JSONElement, _ rhs: JSONElement) -> Bool {
        return self.compareElements(lhs, rhs)
    }
    
    private static func compareElements(lhs: JSONElement, _ rhs: JSONElement) -> Bool {
        switch rhs.value {
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
        case let regex as RegexElement:
            guard let string = lhs.value as? String else {
                return false
            }
            return regex.value.match(string)
        case let classType as TypeElement:
            return classType.isTypeOf(lhs.value)
        default:
            return lhs == rhs
        }
        
        return true
    }
}