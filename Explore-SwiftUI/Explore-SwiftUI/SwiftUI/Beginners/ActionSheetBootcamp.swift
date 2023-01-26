//
//  ActionSheetBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 15/12/22.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
 - We can't use multiple ActionSheet.Button.cancel() in a single ActionSheet. It result in crash saying `UIAlertController can only have one action with a style of UIAlertActionStyleCancel`
 */

fileprivate struct CurrentBtnStyle: ViewModifier {
    let textColor: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(textColor)
            .padding()
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(10)
    }
}
fileprivate extension View {
    func currentBtnStyle(_ color: Color) -> some View {
        self
            .modifier(CurrentBtnStyle(textColor: color))
    }
}

struct ActionSheetBootcamp: View {
    
    @State private var showActionSheet1 = false
    @State private var bgColor = Color.blue
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            
            VStack {
                Button {
                    showActionSheet1.toggle()
                } label: {
                    Text("Default ActionSheet #1")
                        .currentBtnStyle(bgColor)
                }
                .actionSheet(isPresented: $showActionSheet1) {
//                    ActionSheet(title: Text("Title"))
                    ActionSheet(
                        title: Text("Title"),
                        message: Text("Message"),
                        buttons: [
                            .default(Text("Default Label")) {
                                bgColor = .blue
                            },
                            ActionSheet.Button.destructive(Text("Destructive")) {
                                bgColor = .red
                            },
//                            ActionSheet.Button.cancel(), //We can't use
                            ActionSheet.Button.cancel(Text("Dismiss")) {
                                bgColor = .green
                            }
                        ]
                    )
                }
            }
        }
    }
}

struct ActionSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetBootcamp()
    }
}
