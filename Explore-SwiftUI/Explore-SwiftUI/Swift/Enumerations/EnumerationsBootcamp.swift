//
//  EnumerationsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 12/11/22.
//

import SwiftUI

/*
 Source:
 Capture Lists: https://shantaram-kokate-swift.medium.com/capture-list-in-swift-a7d7d1328c84#:~:text=capture%20list%20creates%20a%20local,value%20type%20and%20reference%20type.&text=In%20the%20above%20code%2C%20a,capture%20list%2C%20but%20b%20not.
 
 Definition:
 
 Notes:
 Enumerations:
 - Swift Enum adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial case value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality
 - When it isn’t appropriate to provide a `case` for every enumeration case, you can provide a `default` case to cover any cases that aren’t addressed explicitly
 - For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type
 - You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed
 -  Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.
 - Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.
 - The raw value initializer is a failable initializer, because not every raw value will return an enumeration case
 - enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection. You can also write indirect before the beginning of the enumeration to enable indirection for all of the enumeration’s cases
 
 Closures:
 - Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you
 
 Closures take one of three forms:
    - Global functions are closures that have a name and don’t capture any values.
    - Nested functions are closures that have a name and can capture values from their enclosing function.
    -  Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 
 Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
    - Inferring parameter and return value types from context
    - Implicit returns from single-expression closures
    - Shorthand argument names
    - Trailing closure syntax
 
 - Completion handlers can become hard to read, especially when you have to nest multiple handlers. An alternate approach is to use asynchronous code
 
 - Note: To create a capture list make sure that outer variable and capture variable name should be same
 
 - Why we use capture list?
    Capture List used to break a Retain Cycle
 
 - As an optimization, Swift may instead capture and store a copy of a value if that value isn’t mutated by a closure, and if the value isn’t mutated after the closure is created.Swift also handles all memory management involved in disposing of variables when they’re no longer needed.
 
 - If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses capture lists to break these strong reference cycles
 
 -      If Self is Reference Type,
        func doSomething() {
         someFunctionWithEscapingClosure { self.x = 100 }
         someFunctionWithNonescapingClosure { x = 200 }
        }
 
         func doSomething() {
             someFunctionWithEscapingClosure { [self] in x = 100 }
             someFunctionWithNonescapingClosure { x = 200 }
         }
 
 - If self is an instance of a structure or an enumeration, you can always refer to self implicitly. However, an escaping closure can’t capture a mutable reference to self when self is an instance of a structure or an enumeration. Structures and enumerations don’t allow shared mutability
    
     struct SomeStruct {
         var x = 10
         mutating func doSomething() {
             someFunctionWithNonescapingClosure { x = 200 }  // Ok
             someFunctionWithEscapingClosure { x = 100 }     // Error
         }
     }
 
    The call to the someFunctionWithEscapingClosure function in the example above is an error because it’s inside a mutating method, so self is mutable. That violates the rule that escaping closures can’t capture a mutable reference to self for structures
 
 - Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.
 
 Structures and Classes:
 
 Structures and classes in Swift have many things in common. Both can:
 - Define properties to store values
 - Define methods to provide functionality
 - Define subscripts to provide access to their values using subscript syntax
 - Define initializers to set up their initial state
 - Be extended to expand their functionality beyond a default implementation
 - Conform to protocols to provide standard functionality of a certain kind
 
 Classes have additional capabilities that structures don’t have:
 - Inheritance enables one class to inherit the characteristics of another.
 - Type casting enables you to check and interpret the type of a class instance at runtime.
 - Deinitializers enable an instance of a class to free up any resources it has assigned.
 - Reference counting allows more than one reference to a class instance.
 
 - Classes and actors share many of the same characteristics and behaviors. One of the difference is classes can use inheritance but actors cannot
 
 - All structures have an automatically generated memberwise initializer, which you can use to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name
 - Unlike structures, class instances don’t receive a default memberwise initializer.
 
 - all of the basic types in Swift — integers, floating-point numbers, Booleans, strings, arrays and dictionaries — are value types, and are implemented as structures behind the scenes. All structures and enumerations are value types in Swift.
 
 - Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.
 
 - Unlike value types, reference types are not copied when they’re assigned to a variable or constant, or when they’re passed to a function. Rather than a copy, a reference to the same existing instance is used.
 
 - It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
    * Identical to (===)
    * Not identical to (!==)
 
 - Note that identical to (represented by three equals signs, or ===) doesn’t mean the same thing as equal to (represented by two equals signs, or ==). Identical to means that two constants or variables of class type refer to exactly the same class instance. Equal to means that two instances are considered equal or equivalent in value, for some appropriate meaning of equal, as defined by the type’s designer
 
 */

struct EnumerationsBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EnumerationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EnumerationsBootcamp()
    }
}
