//
//  BasicNavigation.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 13/12/22.
//

import SwiftUI

fileprivate struct BtnModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .padding(.horizontal)
            .background(.black)
            .cornerRadius(10)
    }
}
fileprivate extension View {
    func defaultBtnStyle() -> some View {
        self.modifier(BtnModifier())
    }
}

struct FirstNavScreen: View {
    
    @State private var showMenu = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if showMenu {
                MenuView()
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .transition(AnyTransition.move(edge: .leading))
                    .zIndex(2.0)
            }
            
            NavigationView {
                List {
                    NavigationLink {
                        SecondNavScreen()
                    } label: {
                        Text("One")
                    }

                    Text("Two")
                    Text("Three")
                }
                .listStyle(.grouped)
                .navigationTitle("Navigation Title")
    //            .navigationBarTitleDisplayMode(.large)
    //            .navigationBarHidden(true)
                .navigationBarItems(
                    leading: HStack{
                        Button {
                            withAnimation(Animation.spring()) {
                                self.showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.circle")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                    },
                    trailing: HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "gear")
                            .font(.title3)
                            .foregroundColor(.brown)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "trash.square.fill")
                            .font(.title3)
                            .foregroundColor(.brown)
                        }
                    }
                )
            }
            .navigationViewStyle(.columns)
        }
    }
}

struct SecondNavScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
                .navigationTitle("Second View")
                .navigationBarBackButtonHidden(true)
//                .navigationBarHidden(true)
            
            VStack {
                
                NavigationLink {
                    Text("Third View")
                } label: {
                    Text("Next View")
                        .defaultBtnStyle()
                }
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Dismiss")
                        .defaultBtnStyle()
                }
            }
        }
    }
}

struct MenuView: View {
    var body: some View {
        List {
            ForEach(1..<10) { val in
                Text("Menu Item #\(val)")
            }
        }
        .listStyle(.plain)
        .background(Color.red.opacity(0.4)
                        .ignoresSafeArea())
    }
}

struct BasicNavigation_Previews: PreviewProvider {
    static var previews: some View {
        FirstNavScreen()
    }
}
