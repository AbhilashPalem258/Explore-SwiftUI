//
//  ScrollViewImpModifiers.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 30/12/23.
//

import SwiftUI

/*
 link:
 https://www.youtube.com/watch?v=8YHbhSmiKwU&t=605s
 */

@available(iOS 17.0, *)
struct ScrollViewImpModifiers: View {
    @State private var numOfItems = 10
    var body: some View {
        NavigationStack {
            Form {
                Section("Clip Shape & Flashing Scroll Indicators".uppercased()) {
                    Text("Clip the shape of scrolling content and flash to show indicators on content change")
                    ScrollView(.horizontal) {
                        HScrollContent(color: .red, numOfItems: $numOfItems, shadowRadius: nil)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .clipShape(.rect(cornerRadius: 10))
//                            .clipShape(.capsule)
                            .clipShape(.ellipse)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }
                    .scrollIndicatorsFlash(trigger: numOfItems)
                }
                
                Section("Content Margins".uppercased()) {
                    Text("Add margin to the content of a scroll container")
                    ScrollView(.horizontal) {
                        HScrollContent(color: .green, numOfItems: $numOfItems, shadowRadius: nil)
                    }
                    .border(.green)
//                    .contentMargins(.horizontal, 10, for: .scrollContent)
                    .contentMargins(10, for: .scrollContent)
                }
                
                Section("Default Scroll Anchor".uppercased()) {
                    Text("Specify the default scroll position when the scrollview loads")
                    ScrollView(.horizontal) {
                        HScrollContent(color: .blue, numOfItems: $numOfItems, shadowRadius: nil)
                    }
                    .contentMargins(10, for: .scrollContent)
                    .border(.blue)
                    .defaultScrollAnchor(.center)
                }
                
                Section("Scroll ClipView".uppercased()) {
                    Text("To clip or not clip the content in a scroll view")
                    ScrollView(.horizontal) {
                        HScrollContent(color: .teal, numOfItems: $numOfItems, shadowRadius: 5)
                    }
                    .border(.teal)
                    .scrollClipDisabled()
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("ScrollView")
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        numOfItems += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                            .padding()
                    }
                    Button {
                        numOfItems -= 1
                    } label: {
                        Image(systemName: "minus")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                            .padding()
                    }
                }
            }
        }
    }
}

@available(iOS 17.0, *)
fileprivate struct HScrollContent: View {
    
    let color: Color
    @Binding var numOfItems: Int
    let shadowRadius: CGFloat?
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...numOfItems, id: \.self) { num in
                Rectangle()
                    .fill(color.gradient)
                    .shadow(color: .primary, radius: shadowRadius ?? 0)
                    .frame(width: 70, height: 70)
                    .overlay {
                        Text("\(num)")
                            .font(.title.bold())
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ScrollViewImpModifiers()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
