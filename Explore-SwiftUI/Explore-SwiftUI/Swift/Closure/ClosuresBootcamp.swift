//
//  ClosuresBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 25/01/23.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
 - Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables
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
