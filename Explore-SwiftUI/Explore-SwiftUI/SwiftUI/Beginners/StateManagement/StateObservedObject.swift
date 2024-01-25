//
//  StateObservedObject.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 30/12/22.
//

import SwiftUI

/*
 Source:
 - https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject
 - https://youtu.be/VLUhZbz4arg
 
 Definition:
 
 Notes:
 State:
 - Declare state as private to prevent setting it in a memberwise initializer, which can conflict with the storage management that SwiftUI provides
 
 - To access a state’s underlying value, you use its wrappedValue property. However, as a shortcut Swift enables you to access the wrapped value by referring directly to the state instance.
 
 - Declare state as private in the highest view in the view hierarchy that needs access to the value. Then share the state with any subviews that also need access, either directly for read-only access, or as a binding for read-write access. You can safely mutate state properties from any thread.
 
 - If you need to store a reference type, like an instance of a class, use a StateObject instead.
 
 - If you pass a state property to a subview, SwiftUI updates the subview any time the value changes in the container view, but the subview can’t modify the value. To enable the subview to modify the state’s stored value, pass a Binding instead. You can get a binding to a state value by accessing the state’s projectedValue, which you get by prefixing the property name with a dollar sign ($).
 
 - Unlike a state object, always initialize state by providing a default value in the state’s declaration, as in the above examples. Use state only for storage that’s local to a view and its subviews.
 
 - State property wrapper works even for simple classes but it updates view only when complete variable gets changed instead of it properties
 
 ObservableObject:
 - A type of object with a publisher that emits before the object has changed.
 
- By default an ObservableObject synthesizes an objectWillChange publisher that emits the changed value before any of its @Published properties changes.
 
 ObservedObject:
 - Don’t specify a default or initial value for the observed object. Use the attribute only for a property that acts as an input for a view
 
 - Add the @ObservedObject attribute to a parameter of a SwiftUI View when the input is an ObservableObject and you want the view to update when the object’s published properties change. You typically do this to pass a StateObject into a subview.
 
 EnvironmentObject:
 - A property wrapper type for an observable object supplied by a parent or ancestor view.

 - An environment object invalidates the current view whenever the observable object changes. If you declare a property as an environment object, be sure to set a corresponding model object on an ancestor view by calling its environmentObject(_:) modifier.
 
 StateObject:
 - Use a state object as the single source of truth for a reference type that you store in a view hierarchy. Declare state objects as private to prevent setting them from a memberwise initializer, which can conflict with the storage management that SwiftUI provides.
 
 - SwiftUI creates a new instance of the model object only once during the lifetime of the container that declares the state object. For example, SwiftUI doesn’t create a new instance if a view’s inputs change, but does create a new instance if the identity of a view changes.

 - If you need to store a value type, like a structure, string, or integer, use the State property wrapper instead.
 
 - You can pass a state object into a subview through a property that has the ObservedObject attribute. Alternatively, add the object to the environment of a view hierarchy by applying the environmentObject(_:) modifier to a view.  You can then read the object inside subview or any of its descendants using the EnvironmentObject attribute
 
 - Get a Binding to the state object’s properties using the dollar sign ($) operator. Use a binding when you want to create a two-way connection.
 
 - Use caution when doing this. SwiftUI only initializes a state object the first time you call its initializer in a given view. This ensures that the object provides stable storage even as the view’s inputs change. However, it might result in unexpected behavior or unwanted side effects if you explicitly initialize the state object.
 
 - Explicit state object initialization works well when the external data that the object depends on doesn’t change for a given instance of the object’s container.
 
 Force ReInitialization Of StateObject:
 - If you want SwiftUI to reinitialize a state object when a view input changes, make sure that the view’s identity changes at the same time. One way to do this is to bind the view’s identity to the value that changes using the id(_:) modifier
 
    MyInitializableView(name: name)
     .id(name)
 
 - If your view appears inside a ForEach, it implicitly receives an id(_:) modifier that uses the identifier of the corresponding data element.
 
 - If you need the view to reinitialize state based on changes in more than one value, you can combine the values into a single identifier using a Hasher.
 
     var hash: Int {
         var hasher = Hasher()
         hasher.combine(name)
         hasher.combine(isEnabled)
         return hasher.finalize()
     }
 
     MyInitializableView(name: name, isEnabled: isEnabled)
         .id(hash)
 
 - Be mindful of the performance cost of reinitializing the state object every time the input changes. Also, changing view identity can have side effects. For example, SwiftUI doesn’t automatically animate changes inside the view if the view’s identity changes at the same time. Also, changing the identity resets all state held by the view, including values that you manage as State, FocusState, GestureState, and so on.
 */

fileprivate struct Fruit: Identifiable {
    let id: Int
    let count: Int
    let name: String
}

fileprivate class ViewModel: ObservableObject {
    
    @Published var fruits: [Fruit] = []
    
    init() {
        fetchFruits()
    }
    
    func fetchFruits() {
        let mango = Fruit(id: 1, count: 4, name: "Mango")
        let apple = Fruit(id: 2, count: 5, name: "Apple")
        let sapota = Fruit(id: 3, count: 6, name: "Sapota")
        let jackfruit = Fruit(id: 4, count: 8, name: "Jackfruit")
        
        DispatchQueue.main.async {
            self.fruits += [mango, apple, sapota, jackfruit]
        }
    }
}

struct StateObservedObject: View {
    
    @StateObject private var vm = ViewModel()
    @State private var someBool = true
    
    var body: some View {
        NavigationView {
            List {
                Section("Fruits") {
                    ForEach(vm.fruits) { fruit in
                        HStack {
                            Text(fruit.count.description)
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("State Management")
            .navigationBarItems(trailing:
                NavigationLink(destination: {
                    SecondRandomScreen()
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            )
        }
        .environmentObject(vm)
    }
}

fileprivate struct SecondRandomScreen: View {
    
//    @ObservedObject var vm: ViewModel
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            
            List {
                Section("Fruits") {
                    ForEach(vm.fruits) { fruit in
                        HStack {
                            Text(fruit.count.description)
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationBarTitle("Second Screen")
            .navigationBarItems(trailing:
                NavigationLink(destination: {
                    ThirdRandomScreen()
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            )
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Go Backk")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

fileprivate struct ThirdRandomScreen: View {
    
    @EnvironmentObject private var vm: ViewModel
//    @ObservedObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            List {
                Section("Fruits") {
                    ForEach(vm.fruits) { fruit in
                        HStack {
                            Text(fruit.count.description)
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("Third Screen")
        }
    }
}

struct StateObservedObject_Previews: PreviewProvider {
    static var previews: some View {
        StateObservedObject()
    }
}
