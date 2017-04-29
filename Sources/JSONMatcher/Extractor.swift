import Foundation

struct Extractor {
    func extract<T>(_ object: T) -> BaseElementType {
        let builder = Builder()
        if let jsonString = object as? String {
            let jsonObject = self.extractJSONString(JSONString)
            return builder.buildJSONElement(JSONObject)
        }
        return builder.buildJSONElement(object)
    }

    func isValid<T>(_ object: T) -> Bool {
        if object is NSNull {
            return true
        }
        let element = self.extract(object)
        if element is NullElement {
            return false
        }
        return true
    }

    private func extractJSONString(_ jsonString: String) -> Any? {
        if let data = jsonString.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: [])
        }
        return nil
    }
}
