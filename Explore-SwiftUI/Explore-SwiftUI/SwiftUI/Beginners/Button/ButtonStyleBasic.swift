//
//  ButtonStyleBasic.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI


/*
 Source:
 - https://www.youtube.com/watch?v=aogru1e5-nI&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=58
 
 Definition:
 
 Notes:
 - Button Styles and control size will only be applicable to label of button but not on its frame
 */
struct ButtonStyleBasic: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var ButtonStylesDemo: some View {
        VStack {
            
            Button("Plain") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            
            
            Button("Bordered") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            
            
            Button("Bordered Prominent") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            
            Button("Borderedless") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderless)
            
            Button {
                
            } label: {
                Text("Custom Button")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding()
                    .padding(.horizontal)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10.0)
            }
        }
        .accentColor(.orange)
    }
    
    private var ControlSizeDemo: some View {
        VStack {
            Button("Control Size: Large") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            
            Button("Control Size: Regular") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .controlSize(.regular)
            .buttonStyle(.borderedProminent)
            
            Button("Control Size: Small") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .controlSize(.small)
            .buttonStyle(.borderedProminent)
            
            Button("Control Size: Mini") {
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .controlSize(.mini)
            .buttonStyle(.borderedProminent)
        }
    }

    var body: some View {
        ButtonStylesDemo
    }
}

struct ButtonStyleBasic_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonStyleBasic()
                .preferredColorScheme(.dark)
            
            ButtonStyleBasic()
                .preferredColorScheme(.light)
        }
    }
}
