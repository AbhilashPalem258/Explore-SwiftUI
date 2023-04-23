//
//  ClosuresBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 25/01/23.
//

import SwiftUI

/*
 Source:
 Capture list: https://shantaram-kokate-swift.medium.com/capture-list-in-swift-a7d7d1328c84#:~:text=capture%20list%20creates%20a%20local,value%20type%20and%20reference%20type.&text=In%20the%20above%20code%2C%20a,capture%20list%2C%20but%20b%20not.
 
 Definition:
 
 Notes:
 - Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables
 
 - Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
 
     * Inferring parameter and return value types from context

     * Implicit returns from single-expression closures

     * Shorthand argument names

     * Trailing closure syntax
 
 Capturing:
 - As an optimization, Swift may instead capture and store a copy of a value if that value isn’t mutated by a closure, and if the value isn’t mutated after the closure is created. Swift also handles all memory management involved in disposing of variables when they’re no longer needed.
 
 - capture list creates a local variable in the closure. It is initialized with the value of the variable with the same name in the outer context.
 */

struct ClosuresBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init() {
       compute()
//        globalFunc()
    }
    
    func compute() {
        var a: Int = 10
        let b: Int = 20
        
        
        let someClosure1: (Int, Int) -> Int = {
            $0 + $1
        }
        
        let someClosure: () -> Int = { () -> Int in
            return a + b
        }
        a = 40
        print(someClosure1(a, b))
        
        //closure fn def
        let closure1: (Int, Int) -> Int = { (first, second) in
            first + second
        }
        //calling the fn
        someFunc(add: closure1)
    }
    //fn definition
    func someFunc(add: (Int, Int) -> Int) {
        //add fn call
        print(add(10, 20))
    }
}

struct ClosuresBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ClosuresBootcamp()
    }
}

let someVal: Int = 252

func globalFunc() {
    print(someVal)
}
