//
//  PropertiesBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

import SwiftUI
/*
 Source:
 
 Definition:
 
 Notes:
 - Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures.
 - You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.
 - If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
 - The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They aren’t called while a class is setting its own properties, before the superclass initializer has been called.
 - If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function. For a detailed discussion of the behavior of in-out parameters,
 - Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables don’t need to be marked with the lazy modifier.Local constants and variables are never computed lazily.
 - You can apply a property wrapper to a local stored variable, but not to a global variable or a computed variable.
 - You must declare computed properties — including read-only computed properties — as variable properties with the var keyword, because their value isn’t fixed. The let keyword is only used for constant properties, to indicate that their values can’t be changed once they’re set as part of instance initialization.
 - Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value
 
 You can add property observers in the following places:
 - Stored properties that you define
 - Stored properties that you inherit
 - Computed properties that you inherit
 
 - For an inherited property, you add a property observer by overriding that property in a subclass. For a computed property that you define, use the property’s setter to observe and respond to value changes, instead of trying to create an observer.
 
 - If you implement a willSet observer, it’s passed the new property value as a constant parameter.If you don’t write the parameter name and parentheses within your implementation, the parameter is made available with a default parameter name of newValue.
 
 -  if you implement a didSet observer, it’s passed a constant parameter containing the old property value. You can name the parameter or use the default parameter name of oldValue. If you assign a value to a property within its own didSet observer, the new value that you assign replaces the one that was just set.
 
 InOut Parameters:
 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#In-Out-Parameters
 In-out parameters are passed as follows, This behavior is known as copy-in copy-out or call by value result.:
 - When the function is called, the value of the argument is copied.
 - In the body of the function, the copy is modified.
 - When the function returns, the copy’s value is assigned to the original argument.
 
 - when a computed property or a property with observers is passed as an in-out parameter, its getter is called as part of the function call and its setter is called as part of the function return.
 
 - As an optimization, when the argument is a value stored at a physical address in memory, the same memory location is used both inside and outside the function body. The optimized behavior is known as call by reference; it satisfies all of the requirements of the copy-in copy-out model while removing the overhead of copying. Write your code using the model given by copy-in copy-out, without depending on the call-by-reference optimization, so that it behaves correctly with or without the optimization.
 
 - Within a function, don’t access a value that was passed as an in-out argument, even if the original value is available in the current scope. Accessing the original is a simultaneous access of the value, which violates Swift’s memory exclusivity guarantee. For the same reason, you can’t pass the same value to multiple in-out parameters.
 
 Property Wrapper:
 - To define a property wrapper, you make a structure, enumeration, or class that defines a wrappedValue property.
 
 Type properties:
 - Stored type properties can be variables or constants. Computed type properties are always declared as variable properties, in the same way as computed instance properties.
 - Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself doesn’t have an initializer that can assign a value to a stored type property at initialization time.
 - Stored type properties are lazily initialized on their first access. They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they don’t need to be marked with the lazy modifier.
 - The computed type property examples above are for read-only computed type properties, but you can also define read-write computed type properties with the same syntax as for computed instance properties.
 - You define type properties with the static keyword. For computed type properties for class types, you can use the class keyword instead to allow subclasses to override the superclass’s implementation.
 - In the first of these two checks, the didSet observer sets currentLevel to a different value. This doesn’t, however, cause the observer to be called again.
 
 Optional Chaining:
 - When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that’s optional. john.residence?[0].name
 
 Methods:
 - Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself.
 
 - An instance method has implicit access to all other instance methods and properties of that type. An instance method can be called only on a specific instance of the type it belongs to. It can’t be called in isolation without an existing instance.
 
 - You use the self property to refer to the current instance within its own instance methods.
 
 -  If you don’t explicitly write self, Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method.The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance. In this situation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way. You use the self property to distinguish between the parameter name and the property name.
 
 - Structures and enumerations are value types. By default, the properties of a value type can’t be modified from within its instance methods. However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.
 
 - Mutating methods can assign an entirely new instance to the implicit self property.
 
 - Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration
 
 - Note that you can’t call a mutating method on a constant of structure type, because its properties can’t be changed, even if they’re variable properties
 
 Type Methods:
 -  You indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.
 
 - Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type. This means that you can use self to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.
 
- More generally, any unqualified method and property names that you use within the body of a type method will refer to other type-level methods and properties. A type method can call another type method with the other method’s name, without needing to prefix it with the type name. Similarly, type methods on structures and enumerations can access type properties by using the type property’s name without a type name prefix.
 */
fileprivate class DataImporter {
    var fileName = "data.txt"
}

fileprivate class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    
    init() {
        print("initializationComplete")
    }
    
    func useImporter() {
        print("using Importer")
        print(self.importer)
    }
}

fileprivate class ViewModel: ObservableObject {
    let dataManager: DataManager
    init () {
        dataManager = DataManager()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.dataManager.useImporter()
        }
    }
}

struct PropertiesBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PropertiesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesBootcamp()
    }
}
