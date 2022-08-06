import UIKit

// MARK: - Map Operator

extension Sequence {
//    func map2<T>(_ transform: (Element) -> T) -> [T] {
//        var result = [T]()
//        for item in self {
//            result.append(transform(item))
//        }
//        return result
//    }
    
    func map2<T>(_ transform: (Element) throws -> T) rethrows ->  [T] {
        var result = [T]()
        for item in self {
            result.append(try transform(item))
        }
        return result
    }
    
    func compactMap2<T>(_ transform: (Element) throws -> T?) rethrows -> [T] {
        var result = [T]()
        for item in self {
            if let nonNilItem = try transform(item) {
                result.append(nonNilItem)
            }
        }
        return result
    }
    
    func flatMap2<T: Sequence>(_ transform: (Element) throws -> T) rethrows -> [T.Element] {
        var result = [T.Element]()
        for item in self {
            result.append(contentsOf: try transform(item))
        }
        return result
    }
    
    func contains2(_ element: Element) -> Bool where Element: Equatable {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
    
    func contains2(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        for item in self {
            if try predicate(item) {
                return true
            }
        }
        return false
    }
}


//MARK: - FlatMap
//Examples
let sayings = [
    "Stay Hungry, Stay Foolish.",
    "Try Again. Fail Again. Fail Better",
    "Believe you can and you are halfway there"
]

let words = sayings.flatMap { sentence in
    sentence.components(separatedBy: " ")
}
print(words.contains2("Abhilash"))
print(sayings.contains2 { word in
    return word == "Stay Hungry, Stay Foolish."
})
print(words)

let exist = [[1, 2], [3, 4], [5, 6]]
let compactNew = exist.flatMap2 { $0 }
print(compactNew)

[1,2,3,4].publisher
    .map{$0 * 2}
    .sink { val in
        print(val)
    }
