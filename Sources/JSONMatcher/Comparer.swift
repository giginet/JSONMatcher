import Foundation
/*
struct  Comparer {
    static func compare(lhs: JSONElement, _ rhs: JSONElement) -> Bool {
        return self.compareElements(lhs, rhs)
    }
    
    private static func compareElements(lhs: JSONElement, _ rhs: JSONElement) -> Bool {
        return self.compareAcceptableTypes(lhs.value, rhs.value)
    }
    
    private static func compareArray<T: _ArrayType, U: _ArrayType
        where T.Generator.Element == AcceptableValueType,
        U.Generator.Element == AcceptableValueType>(lhs: T, _ rhs: U) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (element0, element1) in zip(lhs, rhs) {
            if (!compareAcceptableTypes(element0, element1)) {
                return false
            }
        }
        return true
    }
    
    private static func compareDictionary<T: CollectionType, U: CollectionType where T.Generator.Element == (String, AcceptableValueType),
        U.Generator.Element == (String, AcceptableValueType),
        T.Index.Distance == Int,
        U.Index.Distance == Int>(lhs: T, _ rhs: U) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for ((k0, v0), (k1, v1)) in zip(lhs, rhs) {
            if (k0 != k1 || !compareAcceptableTypes(v0, v1)) {
                return false
            }
        }
        return true
    }
    
    private static func compareAcceptableTypes(lhs: AcceptableValueType, _ rhs: AcceptableValueType) -> Bool {
        switch (lhs, rhs) {
        case let (number as NSNumber, expectedNumber as NSNumber):
            return number == expectedNumber
        case let (string as String, expectedString as String):
            return string == expectedString
        case let (bool as Bool, expectedBool as Bool):
            return bool == expectedBool
        case let (null as NSNull, expectedNull as NSNull):
            return null == expectedNull
        case let (array as [AcceptableValueType], expectedArray as [AcceptableValueType]):
            return compareArray(array, expectedArray)
        case let (dictionary as [String: AcceptableValueType], expectedDictionary as [String: AcceptableValueType]):
            return compareDictionary(dictionary, expectedDictionary)
        case let (string as String, regex as Regex):
            return regex.match(string)
        case let (lhs, type) as (AcceptableValueType, Type):
            return type.isKindOf(lhs)
        default:
            return false
        }
    }
}*/