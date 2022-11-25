//
//  ResultBuilderBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 04/11/22.
//

import Foundation
import SwiftUI
import MapKit

fileprivate protocol Drawable {
    func draw() -> String
}

fileprivate struct Line: Drawable {
    let elements: [Drawable]
    func draw() -> String {
        elements.map{$0.draw()}.joined(separator: "")
    }
}

fileprivate struct TextStr: Drawable {
    let content: String
    init(_ content: String) {
        self.content = content
    }
    func draw() -> String {
        return content
    }
}

fileprivate struct Space: Drawable {
    func draw() -> String {
        " "
    }
}

fileprivate struct Stars: Drawable {
    let length: Int
    func draw() -> String {
        [String](repeating: "🌟", count: length).joined(separator: "")
    }
}

fileprivate struct AllCaps: Drawable {
    let content: Drawable
    func draw() -> String {
        return content.draw().uppercased()
    }
}

@resultBuilder
fileprivate struct DrawingBuilder {
    static func buildBlock(_ components: Drawable...) -> Drawable {
        Line(elements: components)
    }
    
    static func buildEither(first component: Drawable) -> Drawable {
        component
    }
    
    static func buildEither(second component: Drawable) -> Drawable {
        component
    }
}

fileprivate class ViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var tftext: String = ""
    
    func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
        return content()
    }
    func caps(@DrawingBuilder content: () -> Drawable) -> Drawable {
        return content()
    }
    func makeGreeting() {
        let greeting: Drawable = draw {
            Stars(length: 4)
            TextStr("Hello")
            Space()
            caps {
                if !tftext.isEmpty {
                    TextStr(tftext)
                } else {
                    TextStr("World!")
                }
            }
            Stars(length: 4)
        }
        text = greeting.draw()
    }
}

struct ResultBuilderBootcamp: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .black], center: .center, startRadius: 0.0, endRadius: 500.0)
                .ignoresSafeArea()
            VStack {
                TextField("Enter name...", text: $vm.tftext)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10.0)
                    .padding()
                
                Button {
                    vm.makeGreeting()
                } label: {
                    Text("Make Greeting")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(10.0)
                }
                
                Text(vm.text)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
        }
    }
}

struct ResultBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ResultBuilderBootcamp()
    }
}
