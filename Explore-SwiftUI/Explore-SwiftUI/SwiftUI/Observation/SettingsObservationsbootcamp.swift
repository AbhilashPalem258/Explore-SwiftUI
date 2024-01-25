//
//  SettingsObservationsbootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 30/12/23.
//

import SwiftUI
import Observation

@available(iOS 17.0, *)
@Observable
class AppSettings {
//    let appNotificationSettings = AppNotificationSettings()
//    let userAddress = UserAddress()
    var appNotificationSettings = AppNotificationSettings()
    var userAddress = UserAddress()
}

@available(iOS 17.0, *)
class AppNotificationSettings {
    var likesYourUpdateEnabled = false
    var commentsYourUpdateEnabled = false
    var commentsAfterYourUpdateEnabled = false
    var shareYourArticle = false
}

@available(iOS 17.0, *)
class UserAddress {
    var apartmentNumber: String = ""
    var streetName: String = ""
    var city: String = ""
    var pincode: String = ""
}

@available(iOS 17.0, *)
struct SettingsObservationsbootcamp: View {
    
    @State private var appSettings = AppSettings()
    
    var body: some View {
        NavigationStack {
//            FirstSettingsScreen(appNotificationSettings: appSettings.appNotificationSettings, userAddress: appSettings.userAddress)
            FirstSettingsScreen(appSettings: appSettings)
        }
        .environment(appSettings)
    }
}

@available(iOS 17.0, *)
struct FirstSettingsScreen: View {
    
    @Bindable var appSettings: AppSettings
    
//    @Bindable var appNotificationSettings: AppNotificationSettings
//    @Bindable var userAddress: UserAddress
    
    @State private var showSecondScreen = false
    
    var body: some View {
        Form {
            Section("Notifications") {
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.likesYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Likes your update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.commentsYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Comments on your update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.commentsAfterYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Comments after your on an update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.shareYourArticle, label: {})
                        .labelsHidden()
                } label: {
                    Text("Share your article")
                }
            }
            Section("Address") {
                TextField("Apt #", text: $appSettings.userAddress.apartmentNumber)
                TextField("Street name", text: $appSettings.userAddress.streetName)
                TextField("City", text: $appSettings.userAddress.city)
                TextField("Pincode", text: $appSettings.userAddress.pincode)
            }
            
            Button("Second Screen") {
                showSecondScreen.toggle()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .padding()
        }
        .navigationTitle("Settings")
        .navigationDestination(isPresented: $showSecondScreen) {
//            SecondSettingsScreen(appNotificationSettings: appNotificationSettings, userAddress: userAddress)
            SecondSettingsScreen(appSettings: appSettings)
        }
    }
}

@available(iOS 17.0, *)
struct SecondSettingsScreen: View {
    
    @Bindable var appSettings: AppSettings
    @State private var showThirdScreen = false
    
//    @Bindable var appNotificationSettings: AppNotificationSettings
//    @Bindable var userAddress: UserAddress

    var body: some View {
        Form {
            Section("Notifications") {
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.likesYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Likes your update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.commentsYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Comments on your update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.commentsAfterYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Comments after your on an update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.shareYourArticle, label: {})
                        .labelsHidden()
                } label: {
                    Text("Share your article")
                }
            }
            Section("Address") {
                TextField("Apt #", text: $appSettings.userAddress.apartmentNumber)
                TextField("Street name", text: $appSettings.userAddress.streetName)
                TextField("City", text: $appSettings.userAddress.city)
                TextField("Pincode", text: $appSettings.userAddress.pincode)
            }
            
            Button("Third Screen") {
                showThirdScreen.toggle()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .padding()
        }
        .navigationTitle("Settings")
        .navigationDestination(isPresented: $showThirdScreen) {
            ThirdSettingsScreen()
        }
    }
}

@available(iOS 17.0, *)
struct ThirdSettingsScreen: View {
    
    @Environment(AppSettings.self) private var appSettings: AppSettings

    var body: some View {
        @Bindable var appSettings = appSettings
        Form {
            Section("Notifications") {
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.likesYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Likes your update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.commentsYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Comments on your update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.commentsAfterYourUpdateEnabled, label: {})
                        .labelsHidden()
                } label: {
                    Text("Comments after your on an update")
                }
                LabeledContent {
                    Toggle(isOn: $appSettings.appNotificationSettings.shareYourArticle, label: {})
                        .labelsHidden()
                } label: {
                    Text("Share your article")
                }
            }
            Section("Address") {
                TextField("Apt #", text: $appSettings.userAddress.apartmentNumber)
                TextField("Street name", text: $appSettings.userAddress.streetName)
                TextField("City", text: $appSettings.userAddress.city)
                TextField("Pincode", text: $appSettings.userAddress.pincode)
            }
            
            Button("Third Screen") {
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .padding()
        }
        .navigationTitle("Settings")
    }
}

@available(iOS 17.0, *)
#Preview {
    SettingsObservationsbootcamp()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
