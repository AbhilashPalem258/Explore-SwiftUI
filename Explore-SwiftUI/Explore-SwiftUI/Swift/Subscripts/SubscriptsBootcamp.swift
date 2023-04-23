//
//  SubscriptsBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

import Foundation

/*
 Source:
 
 Definition:
 
 Notes:
 - You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. Subscripts aren’t limited to a single dimension, and you can define subscripts with multiple input parameters to suit your custom type’s needs.
 
 -  You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type. subscripts can be read-write or read-only. This behavior is communicated by a getter and setter in the same way as for computed properties
 
 - Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return a value of any type
 
 - Like functions, subscripts can take a varying number of parameters and provide default values for their parameters
 
 -  However, unlike functions, subscripts can’t use in-out parameters
 
 - You can also define subscripts that are called on the type itself. This kind of subscript is called a type subscript. You indicate a type subscript by writing the static keyword before the subscript keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that subscript.
 */
