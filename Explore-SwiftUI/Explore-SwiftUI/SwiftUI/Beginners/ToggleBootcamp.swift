//
//  ToggleBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/12/22.
//

import SwiftUI

struct ToggleBootcamp: View {
    @State private var isOnline = false
    var body: some View {
        VStack {
            Text("Status: \(isOnline ? "Online" : "Offline")")
            Toggle(isOn: $isOnline) {
                Text("Change Status")
            }
            Spacer()
        }
    }
}

struct ToggleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToggleBootcamp()
    }
}
