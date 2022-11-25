//
//  DebuggerOperatorsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/10/22.
//

import Foundation
import Combine
import UIKit
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/operators/operatorsDebuggers/operatorsdebuggers.html
 https://www.apeth.com/UnderstandingCombine/operators/operatorsDebuggers/operatorsassertnofailure.html
 Definition:
 
 Notes:
 - However, you’re not actually pausing at a breakpoint per se. You’re pausing in LLDB, but the context is not useful; it will appear as assembler. There are no frame variables. There is no execution pointer in your source code. The only thing you can do after pausing is resume (by clicking the Continue button, or saying continue at the debugger console). Nevertheless, by a judicious use of printing and pausing, you can use .breakpoint calls to step through your pipeline and trace what it does.
 */
fileprivate struct DataService {
    
    enum MyError: Error {
        case tooBig
    }
    
    private var cancellables = Set<AnyCancellable>()

    mutating func printPublisher() {
        [1,2,3,4,5,6,7,8,9,10].publisher
            .print()
            .sink { completion in
                debugPrint("Receive print operator completion: \(completion)")
            } receiveValue: { value in
                debugPrint("Receive print operator value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    mutating func testHandleEvents() {
        //HandleEvent is a publisher, so it doesnt work without a subscriber
        [1,2,3,4,5,6,7,8,9,10].publisher
            .handleEvents(receiveSubscription: { subscription in
                debugPrint("Receive subscription: \(subscription)")
            }, receiveOutput: { value in
                debugPrint("Receive value: \(value)")
            }, receiveCompletion: { completion in
                debugPrint("Receive handle event operator completion: \(completion)")
            }, receiveCancel: {
                debugPrint("Receive cancel")
            }, receiveRequest: { demand in
                debugPrint("Receive Demand: \(demand)")
            })
            .sink { completion in
                debugPrint("Receive print operator completion: \(completion)")
            } receiveValue: { value in
                debugPrint("Receive print operator value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    mutating func testBreakpointPublisher() {
//        [1,2,3,4,5,6,7,8,9,10].publisher
//            .breakpoint(receiveSubscription: { subscription in
//                return false
//            }, receiveOutput: { value in
//                return true
//            }, receiveCompletion: { completion in
//                return true
//            })
        Fail(outputType: Int.self, failure: MyError.tooBig)
            .breakpointOnError()
            .sink { completion in
                debugPrint("Receive print operator completion: \(completion)")
            } receiveValue: { value in
                debugPrint("Receive print operator value: \(value)")
            }
            .store(in: &cancellables)
    }
}

fileprivate class ViewModel: ObservableObject {
    private var dataService: DataService
    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }
    
    func testPrintPublisher() {
        dataService.printPublisher()
    }
    
    func testHandleEventPublisher() {
        dataService.testHandleEvents()
    }
    
    func testBreakPointPublisher() {
        dataService.testBreakpointPublisher()
    }
}

struct DebuggerOperatorsBootcamp: View {
    private let vm = ViewModel()
    var body: some View {
        List {
            Button {
                vm.testPrintPublisher()
            } label: {
                Text("Test Print")
                    .modifier(DefaultBtnModifier())
            }
            
            Button {
                vm.testHandleEventPublisher()
            } label: {
                Text("Test Handle Event")
                    .modifier(DefaultBtnModifier())
            }
            
            Button {
                vm.testBreakPointPublisher()
            } label: {
                Text("Test Breakpoint")
                    .modifier(DefaultBtnModifier())
            }
        }
    }
}

fileprivate struct DefaultBtnModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.black)
            .cornerRadius(10.0)
    }
}
