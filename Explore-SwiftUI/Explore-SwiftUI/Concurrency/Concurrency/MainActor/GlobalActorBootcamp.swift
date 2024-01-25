//
//  GlobalActorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/04/23.
//

import SwiftUI

/*
 Source:
 https://www.youtube.com/watch?v=BRBhMrJj5f4&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=11
 
 Definition:
 
 Notes:
 - A type that represents a globally-unique actor that can be used to isolate various declarations anywhere in the program.
 
 - A type that conforms to the GlobalActor protocol and is marked with the @globalActor attribute can be used as a custom attribute. Such types are called global actor types, and can be applied to any declaration to specify that such types are isolated to that global actor type. When using such a declaration from another actor (or from nonisolated code), synchronization is performed through the shared actor instance to ensure mutually-exclusive access to the declaration.
 
     associatedtype ActorType : Actor
     static var shared: Self.ActorType { get }
     static var sharedUnownedExecutor: UnownedSerialExecutor { get }

 */

@globalActor
fileprivate final class MyGlobalActor {
    static let shared = FruitDataManager()
}

fileprivate actor FruitDataManager {
    func fetchAvailableFruits() -> [String] {
        ["Orange", "kiwi", "Apple", "Banana", "Muskmelon"]
    }
}

fileprivate class ViewModel: ObservableObject {
    
    @Published var dataArr: [String] = []
    
    @MyGlobalActor
    func getFruitsFromDB() {
        Task {
            let manager = FruitDataManager()
            let fruits =  await manager.fetchAvailableFruits()
            await MainActor.run {
                self.dataArr = fruits
            }
        }
    }
    
}

struct GlobalActorBootcamp: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.brown.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ForEach(vm.dataArr, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Global Actor Bootcamp")
            .task {
               await vm.getFruitsFromDB()
            }
        }
    }
}

struct GlobalActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorBootcamp()
    }
}
