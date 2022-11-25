//
//  InheritanceBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

import Foundation
import SwiftUI
/*
 Source:
 
 Definition:
 
 Notes:
 - Classes can also add property observers to inherited properties in order to be notified when the value of a property changes. Property observers can be added to any property, regardless of whether it was originally defined as a stored or computed property
 - Swift classes don’t inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.
 - Overriding by accident can cause unexpected behavior, and any overrides without the override keyword are diagnosed as an error when your code is compiled
 -  The override keyword also prompts the Swift compiler to check that your overriding class’s superclass (or one of its parents) has a declaration that matches the one you provided for the override
 -  You can provide a custom getter (and setter, if appropriate) to override any inherited property, regardless of whether the inherited property is implemented as a stored or computed property at source. The stored or computed nature of an inherited property isn’t known by a subclass—it only knows that the inherited property has a certain name and type
 - You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You can’t, however, present an inherited read-write property as a read-only property
 - You can’t add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
 - Note also that you can’t provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 - You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript
 */

fileprivate class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

fileprivate class Bicycle: Vehicle {
    var hasBasket = false
}

fileprivate class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

fileprivate class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

fileprivate class Scooter: Vehicle {
    
    override var currentSpeed: Double {
        didSet {
            print("DidSet Called for currentspeed")
        }
    }
    
    /*
     INVALID
     You can’t add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
     override var description: String {
         willSet {
             print("WillSet Called with oldValue: \(description) newValue: \(newValue)")
         }
         didSet {
             print("DidSet Called with oldValue: \(oldValue) and newValue: \(description)")
         }
     }
     */
    
//Valid
//    private var _description: String = ""
//    override var description: String {
//        get {
//            return self._description
//        }
//        set {
//            self._description = super.description + "and added description \(newValue)"
//        }
//    }
    
    // You can’t, however, present an inherited read-write property as a read-only property.
    //Compile time Error: Cannot override mutable property with read-only property 'currentSpeed'
//    override var currentSpeed: Double {
//        return super.currentSpeed
//    }
}

fileprivate class ViewModel: ObservableObject {
    
    init() {
        let someVehicle = Vehicle()
        print(someVehicle.description)
        
        let someBicycle = Bicycle()
        someBicycle.hasBasket = true
        someBicycle.currentSpeed = 3.0
        print(someBicycle.description)
        
        let someTandem = Tandem()
        someTandem.currentNumberOfPassengers = 5
        someTandem.hasBasket = true
        someTandem.currentSpeed = 5.0
        print(someTandem.description)
        
        let someTrain = Train()
        someTrain.makeNoise()
    }
}

struct InheritanceBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct InheritanceBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        InheritanceBootcamp()
    }
}
