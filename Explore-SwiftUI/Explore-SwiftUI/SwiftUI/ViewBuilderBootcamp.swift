//
//  ViewBuilderBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 14/07/22.
//

import Foundation
import SwiftUI

//MARK: - Bootcamp 1
struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let icon: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            
            if let icon = icon {
                Image(systemName: icon)
            }

            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .padding()
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New Title", description: "Hello", icon: "heart.fill")
            HeaderViewRegular(title: "Another Title", description: nil, icon: nil)
            HeaderViewGeneric(title: "Generic cell") { Image(systemName: "bolt.fill")
            }
            HeaderViewGeneric(title: "Generic 2") { VStack(alignment: .leading) {
                    Text("Abhilash")
                    Text("Palem")
                }
                Spacer()
                Text("Abhilash")
            }
            Spacer()
        }
    }
}

struct ViewBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderBootcamp()
    }
}

//MARK: - Bootcamp 2
struct LocalViewBuilder: View {
    enum ViewType {
        case one
        case two
        case three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            Text("One")
        case .two:
            HStack {
                Text("Two 1")
                Text("Two 2")
            }
        case .three:
            VStack {
                Text("Three 1")
                Text("Three 2")
            }
        }
    }
}

fileprivate struct LocalViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        LocalViewBuilder(type: .three)
    }
}
