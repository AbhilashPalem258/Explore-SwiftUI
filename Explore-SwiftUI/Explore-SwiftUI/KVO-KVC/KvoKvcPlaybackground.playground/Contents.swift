import UIKit


/*
 Source:
 https://anuragajwani.medium.com/introduction-to-kvo-and-kvc-in-swift-dceadfcf1b28
 https://hackernoon.com/kvo-kvc-in-swift-12f77300c387

 Definition:
 KVC is a form of coding that allows you to access an object’s properties indirectly, using strings to access them instead of the property’s accessors or instead of accessing the variables directly. To enable such mechanism, your classes must comply to the NSKeyValueCoding informal protocol.
 
 we are doing in a way simply assigning values to keys/keyPaths. So we use keys and values, this technique is called Key Value Coding(KVC).
 
 
 Notes:
 - There is protocol known as NSKeyValueCoding informal protocol, which is compulsory to work with KVC. Our classes must be confirmed to this protocol, in order to use KVC & KVO. NSObject confirms to this protocol. So every class that is defined in the Foundation framework and that inherits from NSObject conforms to the NSKeyValueCoding protocol.
 
 - If we give keys different to the property names, The app will crash. When writing KVC-compliant code it’s really important to take care so the key strings actually match to the property names, otherwise the app will simply fall apart. This is not a case when dealing directly with properties, as there’s no chance to do any mistake on their names; the compiler would throw an error in such a case which would drive us to fix it.
 
 - Dynamic dispatch, is one of the cool features in Objective-C. It simply means that the Objective-C runtime decides at runtime which implementation of a particular method or function it needs to invoke. For example, if a subclass overrides a method of its superclass, dynamic dispatch figures out which implementation of the method needs to be invoked, that of the subclass or that of the parent class. This is a very powerful concept.
 
 Swift uses the Swift runtime whenever possible. The result is that it can make a number of optimisations. While Objective-C solely relies on dynamic dispatch, Swift only opts for dynamic dispatch if it has no other choice. If the compiler can figure out at compile time which implementation of a method it needs to choose, it wins a few nanoseconds by opting out of dynamic dispatch.

 Swift runtime chooses other options, such as static and virtual dispatch, over dynamic dispatch whenever possible. It does this to increase performance.Static and virtual dispatch are much faster than dynamic dispatch. Even though we are talking nanoseconds, the net result can be dramatic. Many features we have come accustomed to are only possible because of the dynamic Objective-C runtime, including Core Data and Key-Value Observing.

 Dynamic Dispatch
 By applying the ‘dynamic’ declaration modifier to a member of a class, you tell the compiler that dynamic dispatch should be used to access that member.

 By prefixing a declaration with the ‘dynamic’ keyword, the declaration is implicitly marked with the objc attribute. The objc attribute makes the declaration available in Objective-C, which is a requirement for it to be dispatched by the Objective-C runtime.

 ‘dynamic’ declaration modifier can only be used for members of a class. Structures and enumerations don't support inheritance, which means the runtime doesn't have to figure out which implementation it needs to use.

 So to use KVC & KVO in swift, for the properties we want to observe in KVO we need to declare them with @objc dynamic keyword.
 
 
 -
 PROS
 
 Marking a property as dynamic is all you need to do in order to support change notifications
 CONS

 This drags you back into the Objective-C world via NSObject
 It does not support observing all the properties of an object.
 The code required to observe property changes is really … really horrible!
 
 It would be possible to address the last point by adding a simple adapter around the KVO interfaces.
 */

final class Pokemon: NSObject {
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}

let myPokemon = Pokemon(name: "Charmander")
print(myPokemon.value(forKey: "name")!)

myPokemon.setValue("Charmeleon", forKey: "name")
print(myPokemon.value(forKey: "name")!)

myPokemon.observe(\.name, options: [.new, .old]) { pokemon, info in
    print("Old name \(info.oldValue!)")
    print("New name \(info.newValue!)")
}

myPokemon.name = "Charizard" //works
myPokemon.setValue("Abhilash", forKey: "name") //works

/*
 Output:
 Charmander
 Charmeleon
 Old name Charmeleon
 New name Charizard
 Old name Charizard
 New name Abhilash
 */

//MARK: - Basic Example
class Children: NSObject {
    @objc dynamic var name: String
    @objc dynamic var age: Int
    @objc dynamic var child: Children?
    
    override var description: String {
        "Children(name: \(name), age: \(age), child: \(child))"
    }
    
    override init() {
        self.name = ""
        self.age = 0
        
        super.init()
    }
    
    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool {
        if key == "name" {
            return false
        } else {
            return super.automaticallyNotifiesObservers(forKey: key)
        }
    }
}

var child1 = Children()
child1.child = Children()

child1.setValue("child1", forKey: "name")
print("Child1 name is \(child1.value(forKey: "name")!)")
child1.setValue("10", forKey: "age")
print("Child1 age is \(child1.value(forKey: "age")!)")

child1.setValue("child2", forKeyPath: "child.name")
print("Child1 child's name is \(child1.value(forKeyPath: "child.name")!)")
child1.setValue("20", forKeyPath: "child.age")
print("Child1 child's name is \(child1.value(forKeyPath: "child.age")!)")

class FamilyTree: NSObject {
    
    var child1 = Children()
    var child2 = Children()
    var child3 = Children()
    
    var child1Context = UnsafeMutableRawPointer.allocate(byteCount: 4 * 4, alignment: 1)
    var child2Context = UnsafeMutableRawPointer.allocate(byteCount: 4 * 4, alignment: 2)

    override init() {
        child2.child = child1
        child3.child = child2
        
        super.init()
        
        addObservers()
    }
    
    deinit {
        print("de init")
        self.removeObserver(self, forKeyPath: "name")
        self.removeObserver(self, forKeyPath: "age")
    }
    
    func addObservers() {
        self.child1.addObserver(self, forKeyPath: "name", options: [.new, .old], context: child1Context)
        self.child1.addObserver(self, forKeyPath: "age", options: [.new, .old], context: child1Context)
        self.child2.addObserver(self, forKeyPath: "name", options: [.new, .old], context: child2Context)
        self.child2.addObserver(self, forKeyPath: "age", options: [.new, .old], context: child2Context)
        //context: This is a pointer that can be used as a unique identifier for the change of the property we observe. Usually this is set to nil or NULL.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == child1Context {
            if keyPath == "name" {
                print("Child1 Name is changed")
                print("Child1 Name change: Old value - \(change![NSKeyValueChangeKey.oldKey]!)")
                print("Child1 Name change: New value - \(change![NSKeyValueChangeKey.newKey]!)")
            }
            if keyPath == "age" {
                print("Child1 Age is changed")
                print("Child1 Age change: Old value - \(change![NSKeyValueChangeKey.oldKey]!)")
                print("Child1 Age change: New value - \(change![NSKeyValueChangeKey.newKey]!)")
            }
        } else if context == child2Context {
            if keyPath == "name" {
                print("Child2 Name is changed")
                print("Child2 Name change: Old value - \(change![NSKeyValueChangeKey.oldKey]!)")
                print("Child2 Name change: New value - \(change![NSKeyValueChangeKey.newKey]!)")
            }
            if keyPath == "age" {
                print("Child2 Age is changed")
                print("Child2 Age change: Old value - \(change![NSKeyValueChangeKey.oldKey]!)")
                print("Child2 Age change: New value - \(change![NSKeyValueChangeKey.newKey]!)")
            }
        }
    }
}

var famTree = FamilyTree()
famTree.child1.willChangeValue(forKey: "name")
famTree.child1.name = "Abhilash"
famTree.child1.didChangeValue(forKey: "name")
famTree.child1.age = 10

famTree.child2.willChangeValue(forKey: "name")
famTree.child3.child?.name = "Damini"
famTree.child2.didChangeValue(forKey: "name")

famTree.child3.child?.age = 20
