import Foundation

struct  Comparer {
    let lhs: AnyObject
    let rhs: AnyObject
    
    init(lhs: AnyObject, rhs: AnyObject) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    func compare() -> Bool {
        return true
    }
}