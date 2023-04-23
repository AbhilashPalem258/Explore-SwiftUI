//
//  SequencedGestureDemo.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 27/01/23.
//

import SwiftUI

struct SequencedGestureDemo: View {
    
    @State private var isLongPressing = false
    
    @State private var currentTranslation: CGSize = .zero
    @State private var dragTranslation: CGSize = .zero
    
    enum PressDragState {
        case inactive
        case Pressing
        case dragging(translation: CGSize)
        
        var highlightColor: Color {
            switch self {
            case .inactive:
                return .red
            case .Pressing:
                return .yellow
            case .dragging(_):
                return .green
            }
        }
        
        var translation: CGSize {
            switch self {
            case .dragging(let translation):
                return translation
            default:
                return .zero
            }
        }
    }
    @GestureState private var pressDragGesture = PressDragState.inactive
    
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 1)
        let dragGesture = DragGesture()

        let longPressDragGesture = longPressGesture.sequenced(before: dragGesture)
            .updating($pressDragGesture) { value, state, _ in
                switch value {
                case .first(let isPressing):
                    print("isPressing 1: \(isPressing)")
                    state = .Pressing
                case .second(let isPressing, let dragValue):
                    print("isPressing 2: \(isPressing)")
                    state = .dragging(translation: dragValue?.translation ?? .zero)
                }
            }
            .onEnded { value in
                switch value {
                case .second(_, let value):
                    let translation = value?.translation
                    self.currentTranslation.width += translation?.width ?? 0.0
                    self.currentTranslation.height += translation?.height ?? 0.0
                default:
                    break
                }
            }
        
        Circle()
            .fill(pressDragGesture.highlightColor)
            .frame(width: 100)
            .offset(
                x: currentTranslation.width + pressDragGesture.translation.width,
                y: currentTranslation.height + pressDragGesture.translation.height
            )
            .gesture(longPressDragGesture)
        
//            .onLongPressGesture(minimumDuration: 1.0) {
//                print("isLongPressing: Ended")
//                isLongPressing = false
//            } onPressingChanged: { isPressing in
//                //On Cancellation callback is called
//                print("isPressing: \(isPressing)")
//                isLongPressing = isPressing
//            }
        
//            .gesture(
//                LongPressGesture(minimumDuration: 1.0)
//                    .onChanged { isPressing in
//                        print("isPressing: \(isPressing)")
//                        isLongPressing = isPressing
//                    }
//                    .onEnded { isEnded in
//                        print("isLongPressing: \(isEnded)")
//                        isLongPressing = isEnded
//                    }
//                    .sequenced(before:
//                        DragGesture()
//                            .onChanged{ value in
//                                dragTranslation = value.translation
//                            }
//                            .onEnded { value in
//                                let translation = value.translation
//                                currentTranslation = CGSize(width: currentTranslation.width + translation.width, height:  currentTranslation.height + translation.height)
//                                dragTranslation = .zero
//                            }
//                    )
//            )
            
    }
}

struct SequencedGestureDemo_Previews: PreviewProvider {
    static var previews: some View {
        SequencedGestureDemo()
    }
}
