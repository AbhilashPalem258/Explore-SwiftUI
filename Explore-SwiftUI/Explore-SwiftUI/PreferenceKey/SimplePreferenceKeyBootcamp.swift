//
//  PreferenceKeyBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 14/07/22.
//

import Foundation
import SwiftUI

struct SimplePreferenceKeyBootcamp: View {
    
    @State var triggeredFrom = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Primary Screen")
                Text("Key: \(triggeredFrom)")
                SecondaryView()
            }
            .navigationTitle("Navigation Title")
        }
        .onPreferenceChange(CustomPreferenceKey.self) { value in
            if !value.isEmpty {
                self.triggeredFrom = value
            }
        }
    }
}

fileprivate extension View {
    func customTitle(_ val: String) -> some View {
        preference(key: CustomPreferenceKey.self, value: val)
    }
}

fileprivate struct SecondaryView: View {
    
    @State var newVal: String = ""
    
    var body: some View {
        Text("Secondary View")
            .onAppear {
                getDataFromDB()
            }
            .customTitle(newVal)
            
    }
    
    func getDataFromDB() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            newVal = "Secondary Screen Key"
        }
    }
}

fileprivate struct CustomPreferenceKey: PreferenceKey {
    static let defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

fileprivate struct PreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SimplePreferenceKeyBootcamp()
    }
}
