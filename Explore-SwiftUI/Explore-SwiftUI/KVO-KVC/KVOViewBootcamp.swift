//
//  KVOViewBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 26/10/22.
//

import Foundation
import SwiftUI

//https://medium.com/@aainajain/the-story-of-my-experiments-with-swift-keypath-3a55809ffecf

fileprivate class Person: NSObject {
    @objc dynamic var name: String = "Initial Value"
}

fileprivate class ViewModel: ObservableObject {
    @Published var observedValue: String = ""
    @Published var tfText: String = ""
    let person = Person()
    var personNameObservation: NSKeyValueObservation?
    
    init() {
        observeForName()
    }
    
    func observeForName() {
        personNameObservation = person.observe(\.name, options: [.initial, .new, .old]) { obj, change in
            print(obj)
            if let newVal = change.newValue {
                self.observedValue = newVal
            }
            print(change)
        }
    }
    
    func setName() {
        person.name = tfText
    }
}

struct KVOViewBootcamp: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 0, endRadius: 500)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Name :")
                    TextField("Enter Name", text: $vm.tfText)
                        .padding(.leading)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.white)
                        .cornerRadius(10.0)
                        
                }
                .padding(.bottom, 20)
                Button {
                    vm.setName()
                } label: {
                    Text("Submit")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding()
                        .background(.black)
                        .cornerRadius(10)
                }
                Text(vm.observedValue)
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
        }
    }
}

struct KVOViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        KVOViewBootcamp()
    }
}
