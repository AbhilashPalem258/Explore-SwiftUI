//
//  AvailableAttributeBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/11/22.
//

import Foundation
import SwiftUI

/*
 Source:
 Available - https://www.avanderlee.com/swift/available-deprecated-renamed/
 objc - https://www.hackingwithswift.com/example-code/language/what-is-the-objc-attribute
 objcMembers - https://www.hackingwithswift.com/example-code/language/what-is-the-objcmembers-attribute
 nonobjc - https://jasdev.me/when-to-use-nonobjc
 UIApplicationMain: [
 https://medium.com/@venki0119/role-of-uiapplicationmain-in-ios-app-launch-process-77a00b44ac9d,
 https://medium.com/@venki0119/detecting-user-inactivity-in-the-ios-application-64072532d23
 ]
 Testable: https://medium.com/@ani.sam2015/what-is-testable-c26ee882ada4
 DynamicMemberLookup: https://www.swiftbysundell.com/tips/combining-dynamic-member-lookup-with-key-paths/
 NSCopying: https://www.hackingwithswift.com/example-code/system/how-to-copy-objects-in-swift-using-copy
 
 Declaration Attributes
 - UIApplicationMain
 - main
 - Available
 - Property wrapper
 - testable
    Apply this attribute to an import declaration to import that module with changes to its access control that simplify testing the module’s code. Entities in the imported module that are marked with the internal access-level modifier are imported as if they were declared with the public access-level modifier. Classes and class members that are marked with the internal or public access-level modifier are imported as if they were declared with the open access-level modifier. The imported module must be compiled with testing enabled.
 - Dynamic Callable
 - Dynamic member lookup
 - Unchecked
 - NSCopying
 - NSManaged
 - nonObjc
 - objc
 - objcMembers
 - resultBuilder
 - Inlinable
 - Frozen
 
 Type Attributes
 - autoclosure
 - convention
 - escaping
 - Sendable
 
 Switch Case Attributes
 - unknown
 Definition:
 
 Notes:
 */

struct AvailableAttributeBootcamp: View {
    var body: some View {
        Text("AvailableAttributeBootcamp")
    }
}
