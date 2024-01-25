//
//  PhoneStocks.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/04/23.
//

import Foundation
import SwiftUI

// https://www.youtube.com/watch?v=USz17wtIKG8
final class PhoneStocks {
    private var availablePhones = [
        "Samsung Galaxy",
        "Apple Iphone 12",
        "Apple iPhone 13",
        "Apple iPhone 14",
        "Apple iPhone 15"
    ]
    
    private let lock = DispatchQueue(label: "lock")
    
    func getAvailablePhones() {
        lock.async { [self] in
            print("Available phones for purchase are \(availablePhones)")
        }
    }
    
    func purchase(phone: String) {
        lock.async { [self] in
            guard let index = availablePhones.firstIndex(of: phone) else {
                print("No such phone in stock")
                return
            }
            availablePhones.remove(at: index)
            print(" Congratulations 🎉 on purchase of new \(phone)")
        }
    }
}

actor PhoneStocksActor {
    private var availablePhones = [
        "Samsung Galaxy",
        "Apple Iphone 12",
        "Apple iPhone 13",
        "Apple iPhone 14",
        "Apple iPhone 15"
    ]
        
    func getAvailablePhones() {
        print("Available phones for purchase are \(availablePhones)")
    }
    
    func purchase(phone: String) {
        guard let index = availablePhones.firstIndex(of: phone) else {
            print("No such phone in stock")
            return
        }
        availablePhones.remove(at: index)
        print(" Congratulations 🎉 on purchase of new \(phone)")
    }
}

fileprivate class ViewModel {
    func executeFlow() {
        let phoneStocks = PhoneStocks()
        
        let queue1 = DispatchQueue(label: "label1")
        let queue2 = DispatchQueue(label: "label2")
        
        queue1.async {
            phoneStocks.purchase(phone: "Apple iPhone 15")
        }
        
        queue2.async {
            phoneStocks.getAvailablePhones()
        }
    }
    
    func executeActorFlow() {
        let phoneStocksActor = PhoneStocksActor()
        Task {
            await phoneStocksActor.purchase(phone: "Apple iPhone 15")
        }
        Task {
            await phoneStocksActor.getAvailablePhones()
        }
    }
}

struct PhoneStocksView: View {
    fileprivate let viewModel = ViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.brown.edgesIgnoringSafeArea(.all)
                
                Button {
                    viewModel.executeActorFlow()
                } label: {
                    Text("Execute")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .padding()
                        .padding(.horizontal)
                        .background(.black)
                        .cornerRadius(10)
                }
            }
            .onAppear {
                viewModel.executeActorFlow()
            }
        }
    }
}
