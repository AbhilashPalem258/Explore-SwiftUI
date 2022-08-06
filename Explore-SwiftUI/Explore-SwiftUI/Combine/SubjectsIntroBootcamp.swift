//
//  SubjectsIntroBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 20/07/22.
//

import Foundation
import SwiftUI

/*
 source: https://www.youtube.com/watch?v=n9r3pHypWjk&list=PLSbpzz0GJp5QHQPK3QPjzuwoRn62zDtL8&index=4
 https://www.apeth.com/UnderstandingCombine/publishers/publisherssubject.html
 
 Definition:
 A publisher that exposes a method for outside callers to publish elements.
 
 Notes:
 - Subject is an abstract type
 - It is protocol which inherits from publisher protocol
 - PassthroughSubject, CurrentValueSubject are concrete implementations of Subject protocol
- Passthrough should be used in those cases when you want to emit the value whenever any action is performed. For ex: tap on a button
 - CurrentValueSubject is more useful in those cases when you are actually interested in state of any object. For ex: A switch, eventhough user has not performed any action, switch will have a state either on or off.
 
 https://cocoacasts.com/combine-essentials-combining-publishers-with-combine-zip-operator
 */
