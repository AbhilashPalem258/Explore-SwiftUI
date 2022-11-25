//
//  main.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/11/22.
//

import Foundation

//@main
class MyApp {
    static func main() {
        UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(AppDelegate.self))
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Will finish launching with options")
        return true
    }
}
