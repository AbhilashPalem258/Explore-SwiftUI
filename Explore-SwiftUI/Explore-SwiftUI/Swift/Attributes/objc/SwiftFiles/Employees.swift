//
//  Employees.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/11/22.
//

import Foundation

//If you just want to expose a single method or property, you can mark that method using the @objc attribute. However, if you want all methods in a class to be exposed to Objective-C you can use a shortcut: the @objcMembers keyword
@objcMembers
class Employees: UIView {
    let name = "Abhilash"
    
    func getEmployeeNames() -> String {
        return "Abhilash, the employee"
    }
    
    func getDesignationNames() -> String {
        return "Abhilash, the SSE"
    }
}
