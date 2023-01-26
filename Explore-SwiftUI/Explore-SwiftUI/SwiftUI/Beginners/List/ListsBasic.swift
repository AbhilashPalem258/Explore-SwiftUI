//
//  ListsBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/12/22.
//

import SwiftUI

struct ListsBasic: View {
    
    @State private var fruits: [String] = [
        "Apple",
        "Orange",
        "Mosambi",
        "Papaya",
        "Blueberry",
        "Raspberry"
    ]
    
    @State private var veggies: [String] = [
        "Tomato",
        "Potato",
        "Carrot"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Fruits")) {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit)
                    }
                    .onDelete(perform: performDelete)
                    .onMove { indices, newOffset in
                        move(indices, newOffset)
                    }
                }
                
                Section(header: Text("Veggies")) {
                    ForEach(veggies, id: \.self) { veggie in
                        Text(veggie)
                    }
                }
            }
//            .listStyle(DefaultListStyle())
//            .listStyle(GroupedListStyle())
//            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(trailing: EditButton())
        }
        .accentColor(.red)
    }
    
    func performDelete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    func move(_ indices: IndexSet, _ newOffset: Int) {
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
}

struct ListsBasic_Previews: PreviewProvider {
    static var previews: some View {
        ListsBasic()
    }
}
