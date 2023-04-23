//
//  ARCBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/11/22.
//

import SwiftUI

/*
 Source:
 unowned(unsafe): https://stackoverflow.com/questions/26553924/what-is-the-difference-in-swift-between-unownedsafe-and-unownedunsafe
 
 Definition:
 - class <--> class
 - class <--> struct
 - struct <--> struct
 
 Notes:
 - Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it.
 
 - Because a weak reference doesn’t keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it. Therefore, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated. And, because weak references need to allow their value to be changed to nil at runtime, they’re always declared as variables, rather than constants, of an optional type.
 
 - Property observers aren’t called when ARC sets a weak reference to nil.
 
 - Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime. Unlike a weak reference, an unowned reference is expected to always have a value. As a result, marking a value as unowned doesn’t make it optional, and ARC never sets an unowned reference’s value to nil.
 
 - ARC never sets an unowned reference’s value to nil

 - Use an unowned reference only when you are sure that the reference always refers to an instance that hasn’t been deallocated.If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.
 
 - The examples above show how to use safe unowned references. Swift also provides unsafe unowned references for cases where you need to disable runtime safety checks—for example, for performance reasons. As with all unsafe operations, you take on the responsibility for checking that code for safety.
    You indicate an unsafe unowned reference by writing unowned(unsafe). If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.
 
 - Difference between unowned optional references and weak references is when a property is marked as weak, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated and in case of unowned, ARC never sets an unowned reference’s value to nil. We have to manually set unowned optional to nil
 
 - The underlying type of an optional value is Optional, which is an enumeration in the Swift standard library. However, optionals are an exception to the rule that value types can’t be marked with unowned.
 
 - The optional that wraps the class doesn’t use reference counting, so you don’t need to maintain a strong reference to the optional.
 
 */

//Example 1 - Weak
//Marking any one or two of the property in cycle as weak, resolve Retain cycle
fileprivate class Person {
    let name: String
    weak var apartment: Apartment?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

fileprivate class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

//Example 1 - Unowned
fileprivate class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

fileprivate class CreditCard {
    let number: UInt64
//    unowned let customer: Customer
    unowned var customer: Customer?
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

fileprivate class ViewModel: ObservableObject {
    
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?
    
    var john: Person?
    var unit4A: Apartment?
    
    var customer: Customer?
    
    init() {
        //Deinit demo
        reference1 = Person(name: "John Appleseed")
        reference2 = reference1
        reference3 = reference1
        
        reference1 = nil
        reference2 = nil
//        reference3 = nil
        
        //Strong Referenc cycle demo - Class to Class
        john = Person(name: "John")
        unit4A = Apartment(unit: "unit4A")
        john?.apartment = unit4A
        unit4A?.tenant = john
        
        john = nil
        unit4A = nil
        
        //Unowned demo
//        customer = Customer(name: "Abhilash")
//        var card: CreditCard? = CreditCard(number: 10, customer: customer!)
//        card = nil
        

        //Unowned Optional demo
        customer = Customer(name: "Abhilash")
        let card = CreditCard(number: 10, customer: customer!)
        customer = nil
        card.customer = nil
        print(card.customer)
    }
}

struct ARCBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ARCBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ARCBootcamp()
    }
}
