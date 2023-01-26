//
//  PickerBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 20/12/22.
//

import SwiftUI


/*
 Source:
 
 Definition:
 
 Notes:
 - In this case, ForEach automatically assigns a tag to the selection views, using each option’s id, which it can do because Flavor conforms to the Identifiable protocol.
 - On the other hand, if the selection type doesn’t match the input to the ForEach, you need to provide an explicit tag.
 */

struct PickerBasic: View {
    
    @State private var selection: Int = 0
    @State private var filterOptions = [
        "Menu Item #1",
        "Menu Item #2",
        "Menu Item #3",
        "Menu Item #4"
    ]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
    
    var example1: some View {
        VStack {
            Text("Age :")
            Picker("Picker Title", selection: $selection) {
                ForEach(0..<2) { age in
                    Text("\(age)")
                }
            }
//            .pickerStyle(MenuPickerStyle()) //Default
//            .pickerStyle(WheelPickerStyle())
//            .pickerStyle(InlinePickerStyle())
//            .pickerStyle(SegmentedPickerStyle())
//            .pickerStyle(datePickerStyle(.automatic))
        }
    }
    
    var example2: some View {
        Picker(selection: $selection) {
            ForEach(filterOptions.indices) { index in
                Label(filterOptions[index], systemImage: "heart.fill")
            }
        } label: {
            Text("Choose Option")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.purple)
                .cornerRadius(10.0)
                .shadow(color: .purple, radius: 10.0, x: 0.0, y: 10.0)
        }
        .pickerStyle(MenuPickerStyle())

    }
    
    var segmentedPickerExample: some View {
        Picker(selection: $selection) {
            ForEach(filterOptions.indices) { index in
                Text(filterOptions[index])
            }
        } label: {
            Text("Label")
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(.black)
    }
    
    var body: some View {
        segmentedPickerExample
    }
}

struct PickerBasic_Previews: PreviewProvider {
    static var previews: some View {
        PickerBasic()
    }
}
