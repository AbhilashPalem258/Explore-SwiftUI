//
//  ZipBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 20/07/22.
//

import Combine
import Foundation
import SwiftUI

fileprivate struct UserModel: Identifiable {
    let id = UUID()
    let posts: [Post]
    let comments: [Comment]
}

fileprivate struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

fileprivate struct Comment: Identifiable, Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

class ZipBootcampDataManager {
    private let postsUrlStr = "https://jsonplaceholder.typicode.com/posts"
    private let commentsUrlStr = "https://jsonplaceholder.typicode.com/comments"
    
    private var cancellables = Set<AnyCancellable>()
    
    private func fetchApi<T: Decodable>(urlStr: String, type: T.Type) -> Future<T, Error> {
        Future<T, Error> {[weak self] promise in
            guard let self = self else {
                promise(.failure(URLError(.unknown)))
                return
            }
            guard let url = URL(string: urlStr) else { promise(.failure(URLError(.badURL)))
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    if let response = response as? HTTPURLResponse,
                       response.statusCode >= 200 && response.statusCode < 300,
                       let mimeType = response.mimeType, mimeType == "application/json" {
                        return data
                    }
                    throw URLError(.badServerResponse)
                }
                .decode(type: type, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            print("Decoding Error \(decodingError)")
                        case let urlError as URLError:
                            print("URL Error \(urlError)")
                        default:
                            break
                        }
                    }
                } receiveValue: { values in
                    promise(.success(values))
                }
                .store(in: &self.cancellables)
        }
    }
    
    fileprivate func fetchUser() -> AnyPublisher<UserModel, Error> {
        let postsPublisher: Future<[Post], Error> = self.fetchApi(urlStr: postsUrlStr, type: [Post].self)
        let commentsPublisher: Future<[Comment], Error> = self.fetchApi(urlStr: commentsUrlStr, type: [Comment].self)
        
        return Publishers.Zip(postsPublisher, commentsPublisher)
            .map { (posts, comments) -> UserModel in
                .init(posts: posts, comments: comments)
            }
            .eraseToAnyPublisher()
    }
}

class ZipBootcampViewModel: ObservableObject {
    @Published fileprivate var model: UserModel? = nil
    let dataManager = ZipBootcampDataManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserModel() {
        dataManager.fetchUser()
            .sink { _ in
                
            } receiveValue: { model in
                print(model)
            }
            .store(in: &self.cancellables)

    }
}

struct ZipBootcamp: View {
    @StateObject var vm = ZipBootcampViewModel()
    var body: some View {
        Text("s")
            .onAppear {
                vm.fetchUserModel()
            }
    }

}

struct ZipBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ZipBootcamp()
    }
}
