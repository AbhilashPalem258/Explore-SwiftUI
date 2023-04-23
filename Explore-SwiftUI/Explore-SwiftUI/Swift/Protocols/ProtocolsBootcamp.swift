//
//  ProtocolsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
 - A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of
 
 - A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable
 
 - If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code
 
 - Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.
 
 - Always prefix type property requirements with the static keyword when you define them in a protocol. This rule pertains even though type property requirements can be prefixed with the class or static keyword when implemented by a class. As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static
 
 - Protocols can require specific instance methods and type methods to be implemented by conforming types. These methods are written as part of the protocol’s definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body. Variadic parameters are allowed, subject to the same rules as for normal methods. Default values, however, can’t be specified for method parameters within a protocol’s definition.
 
 - If you mark a protocol instance method requirement as mutating, you don’t need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.
 
 Initializer:
 - You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier
 
 - The use of the required modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.
 
 - You don’t need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes can’t subclassed.
 
 - If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers
 
 - A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer
 
 - Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. To prevent strong reference cycles, delegates are declared as weak references. Marking the protocol as class-only lets the SnakesAndLadders class later in this chapter declare that its delegate must use a weak reference. A class-only protocol is marked by its inheritance from AnyObject
 
 - Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance’s type in an extension.
 
 = You can make a generic type conditionally conform to a protocol by listing constraints when extending the type. Write these constraints after the name of the protocol you’re adopting by writing a generic where clause.
 
 - A protocol can be used as the type to be stored in a collection such as an array or a dictionary
 
 - Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol. Protocol inheritance is always specified in the protocol declaration itself.
 
 - A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits.
 
 - You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list. Use a class-only protocol when the behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics.
 
 - Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols as you need, separating them with ampersands (&)
 
 - You can use the is and as operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol
 
 - Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.
 
 - When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending by writing a generic where clause.
 
 Generics:
 
 -  Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
 
 - Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they’re a placeholder for a type, not a value.
 
 - Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
 
 Associated Types:
 
 - When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that’s used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.
 
 - You can add type constraints to an associated type in a protocol to require that conforming types satisfy those constraints.
 
 - func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable
 
 -  extension Stack where Element: Equatable,
    extension Container where Item == Double
    func endsWith(_ item: Item) -> Bool where Item: Equatable
 
 -  associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
 
 -  subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int
 
 OpaqueeType:
 
 - Error: Protocol can only be used as generic constraint because it has self or associated type requirements
 
 -  Unlike returning a value whose type is a protocol type, opaque types preserve type identity — the compiler has access to the type information, but clients of the module don’t.
 
 - Returning an opaque type looks very similar to using a protocol type as the return type of a function, but these two kinds of return type differ in whether they preserve type identity. An opaque type refers to one specific type, although the caller of the function isn’t able to see which type; a protocol type can refer to any type that conforms to the protocol. Generally speaking, protocol types give you more flexibility about the underlying types of the values they store, and opaque types let you make stronger guarantees about those underlying types.
 
 - Whenever we have associated type in our protocol, we cannot return it as a type. This is because when we return protocol as type. Compiler does not keep track of the concrete type of the exact type that is being returned instead it just takes the protocol as type and because we are having the association of a type of particular type that has been passed by user for this protocol. So because we are having this involvement of an association type here, compiler wants to keep track of the exact type that is being returned. Just by mentioning some keyword before return type we are asking compiler to keep track of exact type.
 */
struct ProtocolsBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProtocolsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsBootcamp()
    }
}
