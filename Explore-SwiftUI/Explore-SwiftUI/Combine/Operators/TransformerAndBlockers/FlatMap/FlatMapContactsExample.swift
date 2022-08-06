//
//  FlatMapContactsExample.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 03/08/22.
//

import Combine
import Foundation
import Contacts
import SwiftUI


class FlatMapContactsExampleViewModel: ObservableObject {
    
    enum NoPoint: Error {
        case userRefusedAuthorization
    }
    
    let contactsBtnClick = PassthroughSubject<Void, Never>()
    @Published var status: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        contactsBtnClickSubscriber()
    }
    
    func contactsBtnClickSubscriber() {
        self.contactsBtnClick
            .flatMap {[weak self] _  in
                self!.checkAccess().publisher
            }
            .flatMap { gotAccess -> AnyPublisher<Bool, Error>  in
                if gotAccess {
                    return Just(true)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    return self.requestAccess().eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(_) = completion {
                    self.status = "Failed"
                }
            } receiveValue: { result in
                self.status = result ? "Authorized" : "UnAuthorized"
            }
            .store(in: &cancellables)
    }
    
    func checkAccess() -> Result<Bool, Error> {
        return Result<Bool, Error> {
            let status = CNContactStore.authorizationStatus(for: .contacts)
            switch status {
            case .notDetermined:
                return false
            case .authorized:
                return true
            default:
                throw NoPoint.userRefusedAuthorization
            }
        }
    }
    
    func requestAccess() -> Future<Bool, Error> {
        Future<Bool, Error> { promise in
            CNContactStore().requestAccess(for: .contacts) { ok, err in
                if ok {
                    promise(.success(true))
                } else {
                    promise(.failure(NoPoint.userRefusedAuthorization))
                }
            }
        }
    }
    
}
struct FlatMapContactsExample: View {
    
    @StateObject private var vm = FlatMapContactsExampleViewModel()
    
    var body: some View {
        VStack {
            Text("Ask Contacts Permission")
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding()
                .background(.blue)
                .cornerRadius(10)
                .onTapGesture {
                    vm.contactsBtnClick.send()
                }
            
            Text(vm.status)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
        }
    }
}
