//
//  InitializerBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 09/11/22.
//

import SwiftUI

/*
 Source:
 Required - https://sonihemant111.medium.com/required-initializers-in-swift-4805de8ade9e
 
 Definition:
 
 Notes:
 Initialization:
 - Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state.
 
 - When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
 
 - initializers don’t have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called
 
 - For class instances, a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.
 
 - If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.
 
 - Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation
 
 - Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain. Classes tend to have very few designated initializers, and it’s quite common for a class to have only one. Every class must have at least one designated initializer.
 
- Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You don’t have to provide convenience initializers if your class doesn’t require them. Create convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in inten
    convenience init(parameters)
 
 - Initializer Delegation for Class Types:
 
    * A designated initializer must call a designated initializer from its immediate superclass.
    * A convenience initializer must call another initializer from the same class.
    * A convenience initializer must ultimately call a designated initializer.
 
    * Designated initializers must always delegate up.
    * Convenience initializers must always delegate across.
 
 - Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use
 
 - Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
 
    * A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
 
    * A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
 
    * A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
 
    * An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
 
 - Superclass initializers are inherited in certain circumstances, but only when it’s safe and appropriate to do so.
 
 - Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties.
 
 - Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply
 
    * If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
 
    * If your subclass provides an implementation of all of its superclass designated initializers — either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition — then it automatically inherits all of the superclass convenience initializers.
 
    * A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
 
 - You can’t define a failable and a nonfailable initializer with the same parameter types and names.
 
 - A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered
 
 - Strictly speaking, initializers don’t return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although you write return nil to trigger an initialization failure, you don’t use the return keyword to indicate initialization success.
 
 - Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case if one is found, or triggers an initialization failure if no matching value exists.
 
 - A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.
 
 - A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.
 
 Resume at OVERIDING A FAILABLE INIT
 
 
- Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.
 
 - If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance
 

 Deinitializers:
 
 - Deinitializers are only available on class types. Class definitions can have at most one deinitializer per class. The deinitializer doesn’t take any parameters and is written without parentheses
 
 - You aren’t allowed to call a deinitializer yourself.
 
 -  Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass doesn’t provide its own deinitializer.
 
 - Because an instance isn’t deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it’s called on
 
 
 ERROR handling:
 - Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.
 - Throwing initializers can propagate errors in the same way as throwing functions.
 - try, try?, try!
 - You can use a defer statement even when no error handling code is involved.
 
 Type Casting:
 - Type casting in Swift is implemented with the is and as operators.
 - Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and false if it’s not.
 - A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!).
 
 - Swift provides two special types for working with nonspecific types:
    * Any can represent an instance of any type at all, including function types.
    * AnyObject can represent an instance of any class type.

 - The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any
 
 */

//MARK:- Example 1
fileprivate class Person {
    var name: String
    var id: UUID
    var state: String
    var country: String
    
    init(name: String, id: UUID, state: String, country: String) {
        self.name = name
        self.id = id
        self.state = state
        self.country = country
    }
    
    convenience init(name: String, id: UUID) {
        self.init(name: name, id: id, state: "NA", country: "NA")
    }
    
    //Failable Initializer
    convenience init?(name: String, id: UUID, dontConstruct: Bool) {
        if dontConstruct {
            return nil
        }
        self.init(name: name, id: id)
    }
}

fileprivate class Employee: Person {
    let company = "Shuttl"
    
    override init(name: String, id: UUID, state: String, country: String) {
        super.init(name: name, id: id, state: state, country: country)
    }
}

// MARK: - Example 2
fileprivate class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[unnamed]")
    }
}

fileprivate class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

//MARK:- Example 3
fileprivate class SomeClass {
    let quantity: Int
    
    init(quantity: Int){
        self.quantity = quantity
    }
    
    //You can’t define a failable and a nonfailable initializer with the same parameter types and names.
    
//    init?(quantity: Int){
//        self.quantity = quantity
//    }
}

//MARK:- Example 4
fileprivate class A {
    let a: Int
    required init(_ msg: String) {
        self.a = 5
        print("MSG: \(msg)")
    }
}

fileprivate class B: A {
    required init(_ msg: String) {
        print("Called B init")
        super.init(msg)
    }
}

fileprivate class ViewModel: ObservableObject {
    let person: Person
    let recipeIngedient: RecipeIngredient
    let someClass: SomeClass
    let someB: B
    
    init() {
        person = Employee(name: "Abhilash", id: UUID(), state: "TG", country: "IN")
        recipeIngedient = RecipeIngredient()
        print(recipeIngedient)
        someClass = SomeClass(quantity: 1)
        someB = B("Abhilash")
    }
}

struct InitializerBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct InitializerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        InitializerBootcamp()
    }
}
