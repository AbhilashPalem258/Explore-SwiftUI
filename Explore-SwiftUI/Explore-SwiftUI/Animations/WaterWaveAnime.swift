//
//  WaterWaveAnime.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

struct WaterWaveAnime: View {
    
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    let bgColor: UIColor = #colorLiteral(red: 0.7062478662, green: 0.7667235732, blue: 0.8084613681, alpha: 1)
    
    var body: some View {
        VStack {
            Image("Damini")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding(10)
                .background(.white, in: Circle())
                .shadow(radius: 10)
            
            Text("Shiny")
                .font(.headline.weight(.bold))
                .foregroundColor(.secondary)
                .shadow(radius: 10)
                .padding(.bottom, 30)
            
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack {
                    let color: UIColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    Image(systemName: "heart.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
//                        .foregroundColor(Color(uiColor: color))
                        .scaleEffect(x: 1, y: 1)
                        .offset(y: -1)
                    
                    WaterWave(progress: 0.7, waveHeight: 0.1, offset: startAnimation)
                        .fill(Color(uiColor: color))
                        .overlay {
                            ZStack {
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: 40, y: 30)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -30, y: 80)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: 50, y: 70)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: 40, y: 100)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: -40, y: 50)
                            }
                        }
                        .mask {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                }
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        startAnimation = size.width
                    }
                }
            }
            .frame(height: 350)
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: bgColor))
        
    }
}

struct WaterWaveAnime_Previews: PreviewProvider {
    static var previews: some View {
        WaterWaveAnime()
    }
}

struct WaterWave: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get{offset}
        set {offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                
                let y: CGFloat = progressHeight + (height * sine)
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}

