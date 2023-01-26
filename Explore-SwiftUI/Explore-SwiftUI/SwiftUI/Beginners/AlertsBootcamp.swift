//
//  AlertsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/12/22.
//

import SwiftUI

fileprivate struct CurrentBtnStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.red)
            .padding()
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(10)
    }
}
fileprivate extension View {
    func currentBtnStyle() -> some View {
        self
            .modifier(CurrentBtnStyle())
    }
}

struct AlertsBootcamp: View {
    
    @State private var showAlert1: Bool = false
    @State private var showAlert2: Bool = false
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            VStack {
                
                //Example 1
                Button {
                    showAlert1.toggle()
                } label: {
                    Text("Default Alert #1")
                        .currentBtnStyle()
                }
                .alert(isPresented: $showAlert1) {
                    Alert(
                        title: Text("Alert #1"),
                        message: Text("Alert with 1 action"),
                        dismissButton: Alert.Button.destructive(Text("Dismiss"))
                    )
                }
                
                //Example 2
                Button {
                    showAlert2.toggle()
                } label: {
                    Text("Default Alert #2")
                        .currentBtnStyle()
                }
                .alert(isPresented: $showAlert2) {
                    Alert(
                        title: Text("Alert #2"),
                        message: Text("Alert with 2 actions"),
                        primaryButton: Alert.Button.default(
                            Text("Proceed".capitalized)
//                                .font(.title2) // Doesnt work
//                                .foregroundColor(.green) // Doesnt work
                        ),
                        secondaryButton: Alert.Button.destructive(
                            Text("Cancel".capitalized)
                        )
                    )
                }
            }
        }
    }
}

struct AlertsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AlertsBootcamp()
    }
}
