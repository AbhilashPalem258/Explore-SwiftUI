//
//  PhaseAnimationsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 05/01/24.
//

import SwiftUI

/*
 link: https://www.youtube.com/watch?v=CS2GLBiRMWE&list=PLBn01m5Vbs4DenOB4CPURKjdDpJkV2sJY&index=8
 
 Notes:
 */

@available(iOS 17.0, *)
struct PhaseAnimationsBootcamp: View {
    var body: some View {
        TabView {
            Basic()
                .tabItem {
                    Label("Basic", image: "1.circle.fill.black")
                }
            
            PhaseWithTrigger()
                .tabItem {
                    Label("Trigger", image: "2.circle.fill.black")
                }
        }
    }
}

@available(iOS 17.0, *)
fileprivate struct Basic: View {
    
    @State private var isDone = false
    @State private var scaleup = false
    
    enum AnimationPhases: CaseIterable {
        case initial
        case final
        
        var fgColor: Color {
            switch self {
            case .initial:
                return .red
            case .final:
                return .green
            }
        }
        
        var rotation: Double {
            switch self {
            case .initial:
                return 0
            case .final:
                return 180
            }
        }
        
        var animation: Animation {
            switch self {
            case .initial:
                return Animation.linear(duration: 0.8)
            case .final:
                return Animation.bouncy(duration: 2.0)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Animation With Completion") {
                    Text("iOS 17 Completion Block")
                    HStack {
                        Spacer()
                        Image(systemName: isDone ? "checkmark.square" : "square")
                            .font(.system(size: 60))
                            .scaleEffect(scaleup ? 1.25 : 1.0)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isDone.toggle()
                                    scaleup.toggle()
                                } completion: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        scaleup.toggle()
                                    }
                                }
                            }
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
                
                Section("Basic Phase Animation") {
                    Text("No Action taken by user - Continuous")
                    HStack {
                        Spacer()
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.system(size: 60))
                            .phaseAnimator(AnimationPhases.allCases) { content, phase in
                                content
                                    .foregroundColor(phase.fgColor)
                                    .rotationEffect(Angle(degrees: phase.rotation))
                            } animation: { phase in
                                phase.animation
                            }
                        Text("Hello World")
                            .bold()
                            .padding()
                            .foregroundStyle(.red)
                            .border(.red)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
            }
            .navigationTitle("Basics")
        }
    }
}

@available(iOS 17.0, *)
fileprivate struct PhaseWithTrigger: View {
    
    @State private var start = false
    
    enum PhaseState: Int, CaseIterable {
        case first, second, third, fourth
        
        var color: Color {
            switch self {
            case .first:
                return .yellow
            case .second:
                return .orange
            default:
                return .red
            }
        }
        
        var rotation: Double {
            -1 * Double(rawValue * 90)
        }
        
        var scale: Double {
            Double(rawValue + 1)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "star")
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)
                    .navigationTitle("Phase Trigger")
                    .phaseAnimator(PhaseState.allCases, trigger: start) { content, phase in
                        content
                            .foregroundStyle(phase.color)
                            .rotationEffect(Angle(degrees: phase.rotation))
                            .scaleEffect(phase.scale)
                    } animation: { phase in
                            .bouncy(duration: 1.0)
                    }
                Spacer()
                Button {
                    start.toggle()
                } label: {
                    Text("START")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}


@available(iOS 17.0, *)
#Preview {
    PhaseAnimationsBootcamp()
}
