import UIKit

//@dynamicMemberLookup
struct Settings {
    var colorTheme = UIColor.orange
    var itemsPageSize = 25
    var keepUserLoggedin = true
    
//    subscript(dynamicMember member: String) -> Any? {
//        switch member {
//        case "colorTheme":
//            return colorTheme
//        case "itemsPageSize":
//            return itemsPageSize
//        case "keepUserLoggedin":
//            return keepUserLoggedin
//        default:
//            return nil
//        }
//    }
}

//let settings = Settings()
////let colorTheme = settings.colorTheme
////let somethinngUnknown = settings.someProperty
//print(colorTheme, somethinngUnknown)

@dynamicMemberLookup
class Reference<Value> {
    private(set) var value: Value
    
    init(value: Value) {
        self.value = value
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Value,T>) -> T {
        self.value[keyPath: keyPath]
    }
}

let reference = Reference(value: Settings())
let theme = reference.colorTheme
print(theme)

extension Reference {
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> T {
        get {
            self.value[keyPath: keyPath]
        }
        set {
            self.value[keyPath: keyPath] = newValue
        }
    }
}

reference.colorTheme = .black
print(reference.colorTheme)
