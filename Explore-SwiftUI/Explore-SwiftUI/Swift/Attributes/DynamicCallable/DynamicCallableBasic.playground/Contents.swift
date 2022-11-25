import UIKit

@dynamicCallable
struct TelephoneExchange {
    //. The return type can be any type.
    func dynamicallyCall(withArguments phoneNumber: [Int]) {
        if phoneNumber == [4,1,1] {
            print("Get Swift help on forums.swift.org")
        } else {
            print("unrecognized Number")
        }
    }
    
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, String>) {
        for (_, val) in args {
            print("Hello \(val)")
        }
    }
}

let dial = TelephoneExchange()

// Use a dynamic method call.
dial(4, 1, 1)
// Prints "Get Swift help on forums.swift.org"

dial(8, 6, 7, 5, 3, 0, 9)
// Prints "Unrecognized number"

// Call the underlying method directly.
dial.dynamicallyCall(withArguments: [4, 1, 1])

dial(name: "Abhilash", age: "Ten")
