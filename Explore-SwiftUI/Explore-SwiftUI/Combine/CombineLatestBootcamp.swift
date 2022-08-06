//
//  CombineLatestBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 20/07/22.
//

import Foundation
import SwiftUI
import Combine

/*
 source: https://www.youtube.com/watch?v=UvXvFa-k6dw&list=PLSbpzz0GJp5QHQPK3QPjzuwoRn62zDtL8&index=2
 
 Definition:
 Subscribes to an additional publisher and publishes a tuple upon receiving output from either publisher.
 
 Subscribes to an additional publisher and invokes a closure upon receiving output from either publisher.
 
 func combineLatest<P>(_ other: P) -> Publishers.CombineLatest<Self, P> where P : Publisher, Self.Failure == P.Failure
 
 Notes:
 - CombineLatest will invoke closure whenever any one of the publisher emits a value
 - If we do not retain our subscription, everything we do here will be flushed or will be freed from memory as soon as this scope completes and because this is an aynchornous call, we dont know when this scope will complete, so that is why we need to retain our subscription, that is why we need set of any cancellables
 */

class CombineLatestBootcampViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var agreedToTnc: Bool = false
    @Published var showSubmitBtn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var contentValidation: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($username, $password, $agreedToTnc)
            .map { (username, password, isAgreed) in
                return username.count > 3 && password.count > 5 && isAgreed
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        addSubmitBtnSubscriber()
    }
    
    func addSubmitBtnSubscriber() {
        contentValidation
            .sink {[weak self] val in
                self?.showSubmitBtn = val
            }
            .store(in: &cancellables)
    }
}

struct CombineLatestBootcamp: View {
    
    @StateObject private var vm = CombineLatestBootcampViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            VStack {
                Text("Sign Up")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                TextField("Username", text: $vm.username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Password", text: $vm.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                
                HStack {
                    Text("Agree to Terms and conditions")
                        .underline()
                        .lineLimit(1)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle(isOn: $vm.agreedToTnc) {}
                        .labelsHidden()
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    Text("SUBMIT")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .opacity(vm.showSubmitBtn ? 1.0 : 0.5)
                }
                .disabled(vm.showSubmitBtn)
                
            }
            .padding()
            .padding(.vertical)
            .background(
                Color.black
                    .blur(radius: 2)
                    .opacity(0.5)
            )
            .padding(.horizontal, 30)
        }
    }
}
