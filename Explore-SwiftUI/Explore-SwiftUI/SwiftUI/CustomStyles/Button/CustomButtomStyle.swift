//
//  CustomButtomStyle.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/01/23.
//

import SwiftUI

struct CustomButtomStyle: View {
    var body: some View {
        VStack {
            Button("Abhilash") {
                
            }
            .buttonStyle(StandardButtonStyle())
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Button("Delete") {
                    
                }
                .buttonStyle(StandardBtnStyle(actionType: .delete))
                
                Spacer()
                
                Button("Cancel") {
                    
                }
                .buttonStyle(StandardBtnStyle(actionType: .cancel))
                
                Button("Ok") {
                    
                }
                .buttonStyle(StandardBtnStyle(actionType: .ok))
            }
            .padding(.horizontal)
        }
    }
}

fileprivate struct StandardButtonStyle: ButtonStyle {
    
    let fgColor: Color = .white
    let bgColor: Color = .red
    let cornerRadius: CGFloat = 10
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .foregroundColor(fgColor)
            .padding()
            .padding(.horizontal)
            .background(bgColor)
            .cornerRadius(cornerRadius)
//            .opacity(configuration.isPressed ? 0.3 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.spring(), value: configuration.isPressed )
    }
}

fileprivate struct StandardBtnStyle: ButtonStyle {
    
    enum ActionType {
        case cancel
        case delete
        case ok
        
        var backgroundColor: Color {
            switch self {
            case .cancel:
                return .white
            case .delete:
                 return .red
            case .ok:
                return .green
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .cancel:
                return .primary
            case .delete:
                 return .white
            case .ok:
                return .white
            }
        }
        
        var strokeColor: Color {
            switch self {
            case .cancel:
                return .black
            case .delete:
                 return .red
            case .ok:
                return .green
            }
        }
        
        var icon: Image {
            switch self {
            case .cancel:
                return Image(systemName: "clear.fill")
            case .delete:
                return Image(systemName: "trash")
            case .ok:
                return Image(systemName: "checkmark.rectangle.fill")
            }
        }
    }
    
    let actionType: ActionType
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            actionType.icon
            configuration.label
        }
        .font(.headline)
        .foregroundColor(actionType.foregroundColor)
        .padding()
        .background(actionType.backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(actionType.strokeColor, lineWidth: 1)
        )
        .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

struct CustomButtomStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtomStyle()
    }
}
