import Foundation
import XCTest

class BaseTestCase: XCTestCase {
    func loadJSONFile(JSONName: String) -> String {
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource(JSONName, ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)
        return String(data: jsonData!, encoding: NSUTF8StringEncoding)!
    }
}
