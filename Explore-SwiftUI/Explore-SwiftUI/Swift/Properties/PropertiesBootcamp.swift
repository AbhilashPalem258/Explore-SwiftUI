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
 - You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.
 - If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
 - The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They aren’t called while a class is setting its own properties, before the superclass initializer has been called.
 - If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function. For a detailed discussion of the behavior of in-out parameters,
 - Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables don’t need to be marked with the lazy modifier.Local constants and variables are never computed lazily.
 - You can apply a property wrapper to a local stored variable, but not to a global variable or a computed variable.
 
 Type properties:
 - Stored type properties can be variables or constants. Computed type properties are always declared as variable properties, in the same way as computed instance properties.
 - Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself doesn’t have an initializer that can assign a value to a stored type property at initialization time.
 - Stored type properties are lazily initialized on their first access. They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they don’t need to be marked with the lazy modifier.
 - The computed type property examples above are for read-only computed type properties, but you can also define read-write computed type properties with the same syntax as for computed instance properties.
 
 Optional Chaining:
 - When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that’s optional. john.residence?[0].name
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
