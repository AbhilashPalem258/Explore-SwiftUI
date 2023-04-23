//
//  PostsFetcher.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 25/01/23.
//

import SwiftUI

class DataFetcher {
    func fetchPosts1(someVal: Int, onCompletion: @escaping (String) -> Void) {
        //Api Call
//        sleep(3)
//        onCompletion("Some Api Response")

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            onCompletion("Some Api Response")
        }
    }
    
    func fetchPosts2(someVal: Int, onChange: (String) -> Void, onCompletion: (String) -> Void) {
        //Api Call
        sleep(3)
        onCompletion("Some Api Response")
    }
}

struct PostsFetcher: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                
                //Single Trailing Closure
                
                    //normal
                DataFetcher().fetchPosts1(someVal: 101, onCompletion: { response in
                    print(response)
                })
                
                    //Trailing Closure syntax
                DataFetcher().fetchPosts1(someVal: 101) { response in
                    print(response)
                }
                
                //Multiple Trailing Closure
                    //normal
                DataFetcher().fetchPosts2(someVal: 12, onChange: { change in
                    print(change)
                }, onCompletion: { (response: String) in
                    print(response)
                })
                
                    //Trailing Closure syntax
                //when 2 or more closures r at the right side end of params, only the first closure param should be written in trailing syntax
                DataFetcher().fetchPosts2(someVal: 12) { change in
                    print(change)
                } onCompletion: { response in
                    print(response)
                }
            }
    }
}

struct PostsFetcher_Previews: PreviewProvider {
    static var previews: some View {
        PostsFetcher()
    }
}
