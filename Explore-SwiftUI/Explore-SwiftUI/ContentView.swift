//
//  ContentView.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                var test = TestPrinter()
                test.test()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
