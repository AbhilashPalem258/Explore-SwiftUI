//
//  CustomGroupBoxStyleBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 24/01/23.
//

import SwiftUI

struct CustomGroupBoxStyleBootcamp: View {
    var body: some View {
        VStack {
            GroupBox("Normal Group Box") {
                CustomProgressStyleBootcamp()
                    .padding()
            }
            .frame(width: 250)
            
            GroupBox("Custom Group Box") {
                CustomProgressStyleBootcamp()
                    .padding()
            }
            .groupBoxStyle(StandardGroupBoxStyle(backgroundColor: .red, labelColor: .white, opacity: 0.8))
            .frame(width: 250)
        }
    }
}

fileprivate struct StandardGroupBoxStyle: GroupBoxStyle {
    let backgroundColor: Color
    let labelColor: Color
    let opacity: Double
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
                    .font(.body.bold())
                    .foregroundColor(labelColor)
                Spacer()
            }
            configuration.content
                .foregroundColor(labelColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(backgroundColor)
                .opacity(1.0)
//            Color(UIColor.systemGroupedBackground)
//                .cornerRadius(5)
        )
    }
}

struct CustomGroupBoxStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomGroupBoxStyleBootcamp()
    }
}
