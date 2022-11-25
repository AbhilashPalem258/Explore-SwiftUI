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
 -  Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass doesn’t provide its own deinitializer.
 - Because an instance isn’t deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it’s called on
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
