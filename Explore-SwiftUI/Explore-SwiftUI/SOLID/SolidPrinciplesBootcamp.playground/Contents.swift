import UIKit
import Darwin


//MARK: - Single Responsibility Principle
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

fileprivate struct DataSservice {
    
    let url = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPosts() {
        apiNetwork { result in
            switch result {
            case .success(let posts):
                print("Posts: \(posts)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func apiNetwork(completion: @escaping (Result<[Post], Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
               (200..<300).contains(statusCode),
               let data = data,
               let mimeType = response?.mimeType,
               mimeType == "application/json" {
                
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
    }
    
    private func handleNetworkResponse() {
        
    }
    
    private func modelParsing() {
        
    }
}
