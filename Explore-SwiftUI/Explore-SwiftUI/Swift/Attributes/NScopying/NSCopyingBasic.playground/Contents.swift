import UIKit
import CoreGraphics

class Person: NSCopying {
    var firstName: String
    var lastName: String
    var age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        print("calling copy")
        let copy = Person(firstName: firstName, lastName: lastName, age: age)
        return copy
    }
}

var person = Person(firstName: "Abhilash", lastName: "Palem", age: 29)
var dupPerson = person

print("Person object address \(UnsafePointer(&person))")
print("Person Dup object address \(UnsafePointer(&dupPerson))")

class Car {
    var name = "Porsche"
}

class Driver {
    let name = "Abhilash"
    let dob = 1993
    @NSCopying var person: Person
    
    init(person: Person) {
        self.person = person
    }
}

let driver = Driver(person: person)
person.lastName = "modified last name"
print(driver.person.lastName)
