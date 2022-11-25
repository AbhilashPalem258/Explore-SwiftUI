//
//  APIConnectablePublisher.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/10/22.
//

import Combine
import Foundation
import SwiftUI

/*
 Source:
 - Developer documentation on Connectable Publishers
 
 Definition:
 - To prevent a publisher from sending elements before you’re ready, Combine provides the ConnectablePublisher protocol. A connectable publisher produces no elements until you call its connect() method.
 - connect() returns a Cancellable instance that you need to retain. You can use this instance to cancel publishing, either by explicitly calling cancel() or allowing it to deinitialize
 
 func connect() -> Cancellable
 func autoconnect() -> Publishers.Autoconnect<Self>

 
 Notes:
 - This multi-subscriber scenario creates a race condition: the publisher can send elements to the first subscriber before the second even exists
 -  makeConnectable() fixes the data task publisher race condition
 - Some Combine publishers already implement ConnectablePublisher, such as Publishers.Multicast and Timer.TimerPublisher. Using these publishers can cause the opposite problem: having to explicitly connect()
 */

fileprivate struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    var title: String
    let body: String
}

fileprivate struct DataService {
    private let urlStr = "https://jsonplaceholder.typicode.com/posts"

    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: urlStr) else {
            return Fail(outputType: [Post].self, failure: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   response.statusCode >= 200 && response.statusCode < 300,
                   let mimeType = response.mimeType,
                   mimeType == "application/json" {
                    return data
                }
                throw URLError(.badServerResponse)
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func makeConnectableFetchPosts() -> Publishers.MakeConnectable<AnyPublisher<[Post], Never>>  {
        return fetchPosts()
            .replaceError(with: [])
            .share()
            .eraseToAnyPublisher()
            .makeConnectable()
    }
}

fileprivate class ViewModel: ObservableObject {
    @Published var posts = [Post]()
    private let dataService: DataService
    private var store = Set<AnyCancellable>()
    private var connection: Cancellable?
    
    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }
    
    func testSharedConnectPublisher() {
        let connectable = dataService
                            .makeConnectableFetchPosts()
        connectable.sink { completion in
            print("Received Completion 1")
        } receiveValue: { posts in
            print("Received posts from 1")
            self.posts = posts.map {
                let modifiedTitle = "\($0.title) 1"
                var result = $0
                result.title = modifiedTitle
                return result
            }
        }
        .store(in: &store)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {[weak self] in
            guard let self = self else {
                return
            }
            connectable.sink { completion in
                print("Received Completion 2")
            } receiveValue: { posts in
                print("Received posts from 2")
                self.posts = posts.map {
                    let modifiedTitle = "\($0.title) 2"
                    var result = $0
                    result.title = modifiedTitle
                    return result
                }
            }
            .store(in: &self.store)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.connection = connectable.connect()
        }
    }
}
struct ConnectablePublisherBootcamp: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                Text(post.title)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
        .onAppear {
            vm.testSharedConnectPublisher()
        }
    }
}

struct ConnectablePublisherBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ConnectablePublisherBootcamp()
    }
}
