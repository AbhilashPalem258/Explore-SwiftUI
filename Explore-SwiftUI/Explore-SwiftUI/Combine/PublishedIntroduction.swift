//
//  PublishedIntroduction.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 19/07/22.
//

import Foundation
import SwiftUI
import Combine

class PublishedIntroductionViewModel: ObservableObject {
    @Published var count: Int = 0
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?
    
    @Published var textFieldtext: String = ""
    @Published var isValidText: Bool = false
    @Published var showSubmitBtn: Bool = false
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addSubmitBtnSubscriber()
    }
    
    func setupTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
            .sink {[weak self] _ in
                guard let self = self else { return }
                if self.count >= 10 {
                    self.timer?.cancel()
                    
                    return
                }
                self.count += 1
            }
    }
    
    func setupTimerA() {
       Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
            .sink {[weak self] _ in
                guard let self = self else { return }
                if self.count >= 10 {
                    self.timer?.cancel()
                    for item in self.cancellables {
                        item.cancel()
                    }
                    return
                }
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldtext
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                print("Text is \(text)")
                return !(text.count < 4)
            }
            .assign(to: \.isValidText, on: self)
            .store(in: &cancellables)
    }
    
    func addSubmitBtnSubscriber() {
        $isValidText
            .combineLatest($count)
            .map { (isValid, count) -> Bool in
                return count == 10 && isValid
            }
            .sink {[weak self] value in
                self?.showSubmitBtn = value
            }
            .store(in: &cancellables)
    }
}

struct PublishedIntroduction: View {
    
    @StateObject private var vm = PublishedIntroductionViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            VStack {
                Text("\(vm.count)")
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(vm.isValidText.description)
                    .font(.title)
                    .foregroundColor(.white)
                
                TextField("Type here...", text: $vm.textFieldtext)
                    .padding(.leading)
                    .frame(height: 55)
                    .font(.headline)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        ZStack(alignment: .leading) {
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .opacity(vm.textFieldtext.isEmpty ? 0.0 :  vm.isValidText ? 0.0 : 1.0)
                            
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .opacity(vm.isValidText ? 1.0 : 0.0)
                        }
                        .font(.headline)
                        .padding(.trailing)
                        
                        ,alignment: .trailing
                    )
                
                Button {
                    
                } label: {
                    Text("Submit")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10.0)
                        .shadow(radius: 10)
                        .padding(.vertical)
                        .opacity(vm.showSubmitBtn ? 1.0 : 0.5)
                }
                .disabled(!vm.showSubmitBtn)
            }
            .padding()
        }
    }
}

struct PublishedIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        PublishedIntroduction()
    }
}
