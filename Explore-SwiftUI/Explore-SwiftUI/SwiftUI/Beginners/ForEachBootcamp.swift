//
//  ForEachBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/12/22.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
 - When you use ForEach, each element you iterate over must be uniquely identifiable. Either conform elements to the Identifiable protocol, or pass a key path to a unique identifier as the id parameter of init(_:id:content:).
 
 - Stack views load their child views all at once, making layout fast and reliable, because the system knows the size and shape of every subview as it loads them. Lazy stacks trade some degree of layout correctness for performance, because the system only calculates the geometry for subviews as they become visible
 
 When choosing the type of stack view to use, always start with a standard stack view and only switch to a lazy stack if profiling your code shows a worthwhile performance improvement
 
 - @State: We are basically telling the view to watch the state of this variable because if this variable changes then we might have to change and update the view
 */
struct ForEachBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ForEachBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ForEachBootcamp()
    }
}
