//
//  LazyVGridBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/12/22.
//

import SwiftUI

struct LazyVGridBootcamp: View {
    let fixedColumns = [
        GridItem.init(.fixed(100), spacing: nil, alignment: nil),
        GridItem.init(.fixed(100), spacing: nil, alignment: nil),
        GridItem.init(.fixed(100), spacing: nil, alignment: nil),
        GridItem.init(.fixed(100), spacing: nil, alignment: nil)
    ]
    
    let flexibleColumns = [
        GridItem.init(.flexible(), spacing: nil, alignment: nil),
        GridItem.init(.flexible(), spacing: nil, alignment: nil),
        GridItem.init(.flexible(), spacing: nil, alignment: nil),
        GridItem.init(.flexible(), spacing: nil, alignment: nil)
    ]
    
    let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100, maximum: 400))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                Rectangle()
                    .fill(.black)
                    .frame(height: 300)
                
                LazyVGrid(columns: fixedColumns, alignment: .trailing, spacing: nil, pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(0..<50) { _ in
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 100)
                        }
                    } header: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .frame(height: 55)
                            .overlay {
                                Text("Section #1")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 10)
                    }
                    
                    Section {
                        ForEach(0..<50) { _ in
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 100)
                        }
                    } header: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .frame(height: 55)
                            .overlay {
                                Text("Section #2")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 4)
                    }
                }
//                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 10)
        }
    }
}

struct LazyVGridBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridBootcamp()
    }
}
