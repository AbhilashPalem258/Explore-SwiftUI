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
 - Observed object so this observed object is great and it makes this view model observable. maybe there's some animation maybe there's something else going on in your app that just causes this view to reload
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
