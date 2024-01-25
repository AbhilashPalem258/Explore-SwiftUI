//
//  EscapingAndCombineNetworking.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 18/07/22.
//

import Foundation
import Combine
import SwiftUI

/*
 source:
 definition:
 Notes:
 - A Future is basically a wrapper where we can take functions that have regular escaping closures and convert them into publishers so that we can use thwm with combine
 - Future: A publisher that eventually produces a single value and then finishes or fails.
 
 references:
 https://www.apeth.com/UnderstandingCombine/publishers/publishersfuture.html
 */

fileprivate struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class PostsDataService {
    
    private let urlStr = "https://jsonplaceholder.typicode.com/posts"
    private var cancellables = Set<AnyCancellable>()
    
    fileprivate func fetchPostsUsingEscaping(completion: @escaping (Result<[Post], Error>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data,
                let response = response as? HTTPURLResponse,
               response.statusCode >= 200 && response.statusCode < 300, let mimeType = response.mimeType, mimeType == "application/json" {
                let decoder = JSONDecoder()
                
                do {
                    let posts = try decoder.decode([Post].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(URLError(.badServerResponse)))
            }
        }
        .resume()
    }
    
    fileprivate func fetchPostsUsingCombine() -> AnyPublisher<[Post], Error> {
        // Combine Discussion
        /*
         1. Sign up for Monthly subscription for package to be delivered
         2. the company would make the package behind the scene
         3. Receive package at your front door
         4. Make sure the package isn't damaged
         5. Open and make sure item is correct
         6. Use the item !!!
         7. Cancellable at any time
         
         1. Create the publisher
         2. Subscribe publisher on background thread
         3. receive on Main thread
         4. tryMap (check that data is good)
         5. decode (Decode data into Post Models)
         6. sink (put the item into our app)
         7. store ()
         */
        
        let url = URL(string: urlStr)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300, let mimeType = response.mimeType, mimeType == "application/json" else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPostsUsingFuture<T: Decodable>() -> Future<T, Error> {
        Future<T, Error> {[weak self] promise in
            guard let self = self else {
                promise(.failure(URLError(.unknown)))
                return
            }
            guard let url = URL(string: self.urlStr) else {
                promise(.failure(URLError(.badURL)))
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    if let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300, let mimeType = response.mimeType, mimeType == "application/json" {
                        return data
                    }
                    throw URLError(.badServerResponse)
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let urlError as URLError:
                            promise(.failure(urlError))
                        default:
                            promise(.failure(error))
                            break
                        }
                    }
                } receiveValue: { posts in
                    promise(.success(posts))
                }
                .store(in: &self.cancellables)
        }
    }
}

fileprivate class PostScreenViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    let dataManager = PostsDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPostsUsingEscaping() {
        dataManager.fetchPostsUsingEscaping { result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
                print("Error in escaping: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPostsUsingCombine() {
        dataManager.fetchPostsUsingCombine()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error in combine: \(error.localizedDescription)")
                default:
                    break
                }
            } receiveValue: {[weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
    
    func fetchPostsUsingFuture() {
        dataManager.fetchPostsUsingFuture()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error in combine: \(error.localizedDescription)")
                default:
                    break
                }
            } receiveValue: {[weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}

struct PostsView: View {
    
    @StateObject fileprivate var vm = PostScreenViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading, spacing: 10) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            vm.fetchPostsUsingFuture()
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
