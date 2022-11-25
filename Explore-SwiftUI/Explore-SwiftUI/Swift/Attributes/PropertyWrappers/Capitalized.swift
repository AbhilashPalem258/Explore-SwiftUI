//
//  Capitalized.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 08/11/22.
//

import Foundation
import Combine
import SwiftUI

@propertyWrapper
fileprivate struct UpperCased {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.uppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.uppercased()
    }
}

fileprivate struct User {
    @UpperCased var firstName: String
    @UpperCased var secondName: String
}

fileprivate class ViewModel: ObservableObject {

    var user = User(firstName: "Abhilash", secondName: "Palem")
    
    @Published var firstNameTFText = ""
    @Published var secondNameTFText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $firstNameTFText
            .sink { val in
                self.user.firstName = val
            }
            .store(in: &cancellables)
        
        $secondNameTFText
            .sink { val in
                self.user.secondName = val
            }
            .store(in: &cancellables)
    }
}

struct CapitalizedPWBootcamp: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 0, endRadius: 300)
                .ignoresSafeArea()
            VStack {
                TextField("Enter First Name", text: $vm.firstNameTFText)
                    .tfModifier()

                
                TextField("Enter Second Name", text: $vm.secondNameTFText)
                    .tfModifier()
                
                Text(vm.user.firstName)
                    .tfModifier()
                Text(vm.user.secondName)
                    .tfModifier()
            }
        }
    }
}

struct CapitalizedPWBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CapitalizedPWBootcamp()
    }
}

extension View {
    func tfModifier() -> some View {
        self
            .modifier(TFModifier())
    }
}

fileprivate struct TFModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.headline)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(10.0)
            .padding()
    }
}
