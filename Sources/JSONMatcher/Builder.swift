import Foundation

struct Builder {
    func buildJSONElement(object: AnyObject) -> BaseElementType {
        switch object {
        case let array as NSArray:
            let array = buildJSONElementArray(array)
            return ArrayElement(array)
        case let dictionary as NSDictionary:
            let dictionary = buildJSONElementDictionary(dictionary)
            return DictionaryElement(dictionary)
        default:
            return buildRawJSONElement(object)
        }
    }
    
    func buildRawJSONElement(object: AnyObject) -> BaseElementType {
        switch object {
        case let int as Int:
            let number = NSNumber(integer: int)
            return NumberElement(number)
        case let int as Double:
            let number = NSNumber(double: int)
            return NumberElement(number)
        case let string as String:
            return StringElement(string)
        case let bool as Bool:
            return BooleanElement(bool)
        case let null as NSNull:
            return NullElement(null)
        default:
            return NullElement(NSNull())
        }
    }
    
    func buildJSONElementArray(array: NSArray) -> ElementArray {
        var result: ElementArray = []
        for element in array {
            if let innerRawArray = element as? NSArray {
                let innerArray = buildJSONElementArray(innerRawArray)
                let arrayElement = ArrayElement(innerArray)
                result.append(arrayElement)
            } else if let innerRawDictionary = element as? NSDictionary {
                let innerDictionary = buildJSONElementDictionary(innerRawDictionary)
                let dictionaryElement = DictionaryElement(innerDictionary)
                result.append(dictionaryElement)
            } else {
                let rawElement = buildRawJSONElement(element)
                result.append(rawElement)
            }
        }
        return result
    }
    
    func buildJSONElementDictionary(dictionary: NSDictionary) -> ElementDictionary {
        var result: ElementDictionary = [:]
        for (k, v) in dictionary {
            guard let k = k as? String else {
                continue
            }
            if let innerRawArray = v as? NSArray {
              let innerArray = buildJSONElementArray(innerRawArray)
                let arrayElement = ArrayElement(innerArray)
                result[k] = arrayElement
            } else if let innerRawDictionary = v as? NSDictionary {
                let innerDictionary = buildJSONElementDictionary(innerRawDictionary)
                let dictionaryElement = DictionaryElement(innerDictionary)
                result[k] = dictionaryElement
            } else {
                let rawElement = buildRawJSONElement(v)
                result[k] = rawElement
            }
        }
        return result
    }
}