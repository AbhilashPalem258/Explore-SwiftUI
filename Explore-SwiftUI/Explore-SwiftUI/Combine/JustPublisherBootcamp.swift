//
//  JustPublisherBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/07/22.
//

import Foundation
import SwiftUI
import Combine

/*
 Source:
 https://www.youtube.com/watch?v=yBj5zqvrMqA
 
 Definition:
 - A publisher that emits an output to each subscriber just once, and then finishes.
 
 Just publisher is just a mechanism to get a response from a publisher just once
 example: if you are making an api call and you just want to get the response one time once it's done, you'll use the just publisher
 
 Notes:
 */
fileprivate struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

fileprivate struct DataManager {
        
    func fetchPosts() -> AnyPublisher<[Post], Never> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            return Just([Post]()).eraseToAnyPublisher()
            
        }
       return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300, let mimeType = response.mimeType, mimeType == "application/json" {
                    return data
                }
                throw URLError(.badServerResponse)
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .catch ({ _ in
                Just([Post]())
            })
            .eraseToAnyPublisher()
    }
}

class JustPublisherBootcampViewModel: ObservableObject {
    @Published fileprivate var posts: [Post] = []
    private let dataManager = DataManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        dataManager.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink { comletion in
                print("Finished")
            } receiveValue: {[weak self] postArr in
                print("Posts is \(self?.posts ?? [])")
                self?.posts = postArr
            }
            .store(in: &cancellables)
    }
}
struct JustPublisherBootcamp: View {
    @StateObject var vm = JustPublisherBootcampViewModel()
    var body: some View {
        Text("S")
            .onAppear {
                vm.fetchPosts()
            }
    }
}

struct JustPublisherBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        JustPublisherBootcamp()
    }
}
