//
//  DatePickerBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/12/22.
//

import SwiftUI

struct DatePickerBasic: View {
    
    @State private var selectedDate: Date = Date()
    
    var example1: some View {
        ZStack {
            Color.teal.ignoresSafeArea()
            
            VStack {
                DatePicker("Date Picker", selection: $selectedDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(.red)
            }
        }
    }
    
    var body: some View {
        example1
    }
}

struct DatePickerBasic_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBasic()
    }
}
