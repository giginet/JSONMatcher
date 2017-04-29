import Foundation
import Nimble

struct  Comparer {
    func compare<T, U>(_ lhs: T, _ rhs: U) -> Bool {
        return self.compareRawValueType(lhs, rhs)
    }

    func include<T, U>(_ lhs: T, _ rhs: U) -> Bool {
        return self.includeRawValueType(lhs, rhs)
    }

    private func compareArray(_ lhs: ArrayElement, _ rhs: ArrayElement) -> Bool {
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

    private func compareDictionary(_ lhs: DictionaryElement, _ rhs: DictionaryElement) -> Bool {
        guard lhs.value.count == rhs.value.count else {
            return false
        }

        for (k0, v0) in lhs.value {
            if let v1 = rhs.value[k0] {
                if !compareRawValueType(v0, v1) {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }

    private func compareRawValueType<T, U>(_ lhs: T, _ rhs: U) -> Bool {
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
            return lhs.type == rhs.value.rawType
        case let (lhs as StringElement, rhs as TypeElement):
            return lhs.type == rhs.value.rawType
        case let (lhs as BooleanElement, rhs as TypeElement):
            return lhs.type == rhs.value.rawType
        case let (lhs as ArrayElement, rhs as TypeElement):
            return lhs.type == rhs.value.rawType
        case let (lhs as DictionaryElement, rhs as TypeElement):
            return lhs.type == rhs.value.rawType
        case let (lhs as NullElement, rhs as TypeElement):
            return lhs.type == rhs.value.rawType
        default:
            return false
        }
    }

    private func includeRawValueType<T, U>(_ lhs: T, _ rhs: U) -> Bool {
        if let lhs = lhs as? ArrayElement {
            for element in lhs.value {
                if includeRawValueType(element, rhs) {
                    return true
                }
            }
        } else if let lhs = lhs as? DictionaryElement,
            let rhs = rhs as? DictionaryElement {
            if includeDictionary(lhs, rhs) {
                return true
            }
            for (_, value0) in lhs.value {
                if includeRawValueType(value0, rhs) {
                    return true
                }
            }
        } else if let lhs = lhs as? DictionaryElement {
            for (_, value) in lhs.value {
                if includeRawValueType(value, rhs) {
                    return true
                }
            }
        }
        return self.compareRawValueType(lhs, rhs)
    }

    private func includeDictionary(_ lhs: DictionaryElement, _ rhs: DictionaryElement) -> Bool {
        for (key1, value1) in rhs.value {
            if let value0 = lhs.value[key1] {
                if !includeRawValueType(value0, value1) {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
}
