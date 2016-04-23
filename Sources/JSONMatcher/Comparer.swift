import Foundation
import SwiftyJSON

struct  Comparer {
    let json: JSON
    let expected: AnyObject
    
    init(json: JSON, expected: AnyObject) {
        self.json = json
        self.expected = expected
    }
    
    func compare() -> Bool {
        return self.compareElements(self.json, self.expected)
    }
    
    private func compareElements(json: JSON,
                                 _ object: AnyObject) -> Bool {
        switch json.type {
        case .Array:
            for (index, elem) in json.arrayValue.enumerate() {
                guard let array = object as? Array<AnyObject> else {
                    return false
                }
                
                if (!compareElements(elem, array[index])) {
                    return false
                }
            }
        case .Dictionary:
            for (key, elem) in json {
                guard let dict = object as? Dictionary<String, AnyObject> else {
                    return false
                }
                guard let expectedElem = dict[key] else {
                    return false
                }
                if (!compareElements(elem, expectedElem)) {
                    return false
                }
            }
        default:
            switch object {
            case let object as Regex:
                if let string = json.string {
                    return object.match(string)
                }
                return false
            case let object as Type:
                return json.type == object
            default:
                let expectedJSON = JSON(object)
                return json == expectedJSON
            }
            
        }
        
        return true
    }
}