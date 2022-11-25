//
//  DebounceOperatorBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/08/22.
//

import Combine
import Foundation
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/operators/operatorsTimers/operatorsdebounce.html
 
 Definition:
 
 Notes:
 */

fileprivate let df: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .long
    formatter.dateStyle = .none
    
    return formatter
}()

fileprivate struct DataService {
    
    let mySubject = PassthroughSubject<(Int, Date), Never>()
    
    func makeDebouncePublisher() {
        let bounces: [(Int, TimeInterval)] = [
            (0, 0),
            (1, 0.25),
            (2, 1),
            (3, 1.25),
            (4, 1.5),
            (5, 2.2),
        ]
        
        for bounce in bounces {
            DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
                mySubject.send((bounce.0, Date.now))
            }
        }
    }
}

fileprivate class ViewModel: ObservableObject {
    @Published var items: [String] = []
    @Published var TFText: String = ""
    @Published var searchText: String = ""
    
    private let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $TFText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink {[weak self] val in
                self?.searchText = val
            }
            .store(in: &cancellables)
    }
    
    func makeDebouncePublisher() {
        dataService.mySubject
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { val in
                self.items.append("VALUE: \(val.0), At \(df.string(from: .now)) Received value, Timestamp: \(df.string(from: val.1)) SENT: \(String(format: "%.2f", Date.now.timeIntervalSince(val.1))) seconds ago \n")
            }
            .store(in: &cancellables)
        
        dataService.makeDebouncePublisher()
    }
}

struct DebounceOperatorBootcamp: View {
    
    @StateObject private var vm = ViewModel()
    
    @ViewBuilder private var publisherView: some View {
        Text("Start Publishing")
            .font(.system(size: 25, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding()
            .background(.blue)
            .cornerRadius(10)
            .onTapGesture {
                vm.makeDebouncePublisher()
            }
        
//        HStack(alignment: .top) {
            VStack {
                ForEach(vm.items, id: \.self) { item in
                    Text("\(item)")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .background(.red)
                }
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.blue)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Spacer()
    }
    
    private var TextFieldSearchView: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 50, endRadius: 500)
                .ignoresSafeArea()
            
            VStack(spacing: 44) {
                TextField("Search here...", text: $vm.TFText)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                Text(vm.searchText)
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                
                Spacer()
            }
        }
    }
    
    var body: some View {
        publisherView
    }
}

struct DebounceOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DebounceOperatorBootcamp()
    }
}
