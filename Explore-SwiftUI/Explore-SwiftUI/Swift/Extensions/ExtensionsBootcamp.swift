//
//  ExtensionsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

import SwiftUI

/*
 Source:
 Why extensions can't contain stored properties? - https://www.youtube.com/watch?v=3R5kOm2aijY 7:28 time.
 
 Definition:
 
 Notes:
 Extensions in Swift can:
    - Add computed instance properties and computed type properties
    - Define instance methods and type methods
    - Provide new initializers
    - Define subscripts
    - Define and use new nested types
    - Make an existing type conform to a protocol
 
 - Extensions can add new functionality to a type, but they can’t override existing functionality.
 
 - If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 
 - Extensions can add new computed properties, but they can’t add stored properties, or add property observers to existing properties.
 
 - Extensions can add new convenience initializers to a class, but they can’t add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
 
 - If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and doesn’t define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension’s initializer
 */

fileprivate struct DataManager {
    
}

fileprivate class ViewModel: ObservableObject {
    
}

struct ExtensionsBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ExtensionsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionsBootcamp()
    }
}
