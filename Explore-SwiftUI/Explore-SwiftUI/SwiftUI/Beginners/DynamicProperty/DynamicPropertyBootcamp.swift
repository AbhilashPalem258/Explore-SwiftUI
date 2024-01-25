//
//  DynamicPropertyBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 28/02/23.
//

import SwiftUI

/*
 Source:
 - https://www.hackingwithswift.com/plus/intermediate-swiftui/creating-a-custom-property-wrapper-using-dynamicproperty
 - https://khorbushko.github.io/article/2021/01/08/dynamicProperty.html
 - nonmutating keyword: https://medium.com/swift-programming/the-why-of-nonmutating-7ecd2cf17ecf
 
 Definition:
 
 Notes:
 - nonmutating: you can explicitly tell the compiler that this accessor won’t mutate its enclosing type. For your own safety the compiler won’t let you access any mutating member of the type from this accessor and constancy will be preserved. But during compile-time checks, the compiler won’t prevent you to call the setter on a const instance of the given type !
 */
@propertyWrapper
struct Document: DynamicProperty {
    @State private var value: String
    private let url: URL
    
    init(_ filename: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        url = paths[0].appendingPathComponent(filename)
        
        let initialText = (try? String(contentsOf: url)) ?? ""
        _value = State(wrappedValue: initialText)
    }
    
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            do {
                try newValue.write(to: url, atomically: true, encoding: .utf8)
                value = newValue
            } catch {
                print("Failed to write data to file")
            }
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}

struct DynamicPropertyBootcamp: View {
    
    @Document("abhilash.txt") private var document
//    private var document = Document("abhilash.txt")
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $document)
//                TextEditor(text: document.projectedValue)

                Button("Change document") {
                    document = String(Int.random(in: 1...1000))
//                    document.wrappedValue = String(Int.random(in: 1...1000))
                }
            }
            .navigationTitle("SimpleText")
        }
    }
}

struct DynamicPropertyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DynamicPropertyBootcamp()
    }
}
