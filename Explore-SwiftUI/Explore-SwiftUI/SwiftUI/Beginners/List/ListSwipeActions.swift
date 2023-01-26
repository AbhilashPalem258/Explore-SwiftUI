//
//  ListSwipeActions.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI

struct ListSwipeActions: View {
    
    @State private var fruits: [String] = [
        "Apple",
        "Orange",
        "Mosambi",
        "Papaya",
        "Blueberry",
        "Raspberry"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit.capitalized)
                            .font(.headline)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    print("Tapped on Archive")
                                } label: {
                                    Text("Archive")
                                }
                                .tint(.green)
                                
                                Button {
                                    print("Tapped on Save")
                                } label: {
                                    Text("Save")
                                }
                                .tint(.blue)
                                
                                Button {
                                    print("Tapped on Junk")
                                } label: {
                                    Text("Junk")
                                }
                                .tint(.black)
                            }
                    }
                } header: {
                    Text("Fruits")
                }
            }
            .navigationTitle("List Swipe Actions")
        }
    }
}

struct ListSwipeActions_Previews: PreviewProvider {
    static var previews: some View {
        ListSwipeActions()
    }
}
