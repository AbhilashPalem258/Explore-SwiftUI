//
//  PredefinedScrollTargetBehaviour.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 31/12/23.
//

import SwiftUI

/*
 link:
 https://www.youtube.com/watch?v=8YHbhSmiKwU&t=605s
 */

@available(iOS 17.0, *)
struct PredefinedScrollTargetBehaviour: View {
    
    @State private var colors: [Color] = [.red, .blue, .green, .teal, .cyan, .orange]
    @State private var pagingScrollID: Int?
    @State private var viewAlignedScrollID: Int?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 18) {
                Text("Paging")
                    .font(.title3.bold())
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(0..<colors.count, id: \.self) { index in
                            Rectangle()
                                .foregroundStyle(colors[index])
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .overlay {
                                    Text("\(index)")
                                        .font(.largeTitle.bold())
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $pagingScrollID)
                .scrollTargetBehavior(.paging)
                .onChange(of: pagingScrollID) {
                    print("pagingScrollID: \(String(describing: pagingScrollID))")
                }
                
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                        withAnimation(.snappy) {
                            pagingScrollID = colors.indices.first
                        }
                    } label: {
                        Text("First")
                    }
                    
                    if let pagingScrollID {
                        Text(colors[pagingScrollID].description)
                            .textCase(.uppercase)
                            .font(.headline.bold())
                    }
                    
                    Button {
                        withAnimation(.snappy) {
                            pagingScrollID = colors.indices.last
                        }
                    } label: {
                        Text("Last")
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                
                Text("View Aligned")
                    .font(.title3.bold())
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<colors.count, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(colors[index])
                                .containerRelativeFrame(.horizontal)
                                .overlay {
                                    Text("\(index)")
                                        .font(.largeTitle.bold())
                                        .foregroundStyle(.white)
                                }
                                .scrollTransition { content, phase in
                                    content
                                        .rotation3DEffect(Angle(degrees: phase.value * -30.0), axis: (0,1,0))
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .contentMargins(.horizontal, 10, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $viewAlignedScrollID)
                
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                        withAnimation(.spring) {
                            viewAlignedScrollID = colors.indices.first
                        }
                    } label: {
                        Text("First")
                    }
                    
                    if let viewAlignedScrollID {
                        Text(colors[viewAlignedScrollID].description)
                            .textCase(.uppercase)
                            .font(.headline.bold())
                    }
                    
                    Button {
                        withAnimation(.spring) {
                            viewAlignedScrollID = colors.indices.last
                        }
                    } label: {
                        Text("Last")
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Scroll Target Behaviour")
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    PredefinedScrollTargetBehaviour()
}
