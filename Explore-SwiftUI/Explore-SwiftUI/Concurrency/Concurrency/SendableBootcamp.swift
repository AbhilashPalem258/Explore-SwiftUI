//
//  SendableBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/04/23.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
 - The Sendable protocol indicates that value of the given type can be safely used in concurrent code.
 */

fileprivate actor CurrentUserManager {
//    func updateDB(userInfo: MyUserInfo) {
//
//    }
    
    func updateDB(userInfo: MyClassUserInfo) {
        
    }
}

fileprivate struct MyUserInfo: Sendable {
    let name: String
    var age: Int
}

fileprivate final class MyClassUserInfo: @unchecked Sendable {
    var name: String = ""
    var age: Int = 0
    
    private var lock = DispatchQueue(label: "lock")
    
    func updateName(name: String) {
        lock.async {
            self.name = name
        }
    }
}

fileprivate class ViewModel {
    func execute() {
        Task {
            let userManager = CurrentUserManager()
//            await userManager.updateDB(userInfo: MyUserInfo(name: "NAme", age: 20))
            await userManager.updateDB(userInfo: MyClassUserInfo())
        }
    }
}

struct SendableBootcamp: View {
    private let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SendableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendableBootcamp()
    }
}
