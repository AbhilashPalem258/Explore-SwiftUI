//
//  BasicMenuBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/01/23.
//

import SwiftUI

/*
 Source:
 
 Definition:
 
 Notes:
 */
struct BasicMenuBootcamp: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.red.ignoresSafeArea()
                
                VStack {
                    Menu {
                        Button("Sort By Name") {
                            
                        }
                        Button("Sort By Country") {
                            
                        }
                        Button("Sort By Region") {
                            
                        }
                    } label: {
                        Text("Menu")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.red)
                            .padding()
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(10)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Menu {
                            Section {
                                Button("UPDATE") {
                                    
                                }
                                Button("DELETE") {
                                    
                                }
                            }
                            Section {
                                Menu("CANCEL") {
                                    Button("RETURN") {
                                        
                                    }
                                    Button("DISMISS") {
                                        
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .scaledToFit()
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .navigationTitle("Menu Bootcamp")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct BasicMenuBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BasicMenuBootcamp()
    }
}
