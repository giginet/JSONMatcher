import Foundation

struct Extractor {
    func extract<T>(object: T) -> BaseElementType {
        let builder = Builder()
        if let JSONString = object as? String {
            let JSONObject = self.extractJSONString(JSONString)
            return builder.buildJSONElement(JSONObject)
        }
        return builder.buildJSONElement(object)
    }
    
    private func extractJSONString(JSONString: String) -> AnyObject? {
        if let data = JSONString.dataUsingEncoding(NSUTF8StringEncoding) {
            return try? NSJSONSerialization.JSONObjectWithData(data, options: [])
        }
        return nil
    }
}