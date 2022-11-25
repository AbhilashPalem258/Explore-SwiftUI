//
//  ApplyDelayAndRetryOperator.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 16/08/22.
//

import Combine
import Foundation
import SwiftUI

//MARK: - Single Responsibility Principle
fileprivate struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

fileprivate struct DataModel {
    enum State {
        case success([Post])
        case error(Error)
    }
    
    let state: State
}

fileprivate struct DataService {
    let urlStr = "https://jsonplaceholder.typicode.com/posts"
    func makeApplyAndDelayOperator() -> AnyPublisher<DataModel, Never> {
        let url = URL(string: urlStr)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .delay(3, retry: 3, scheduler: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode < 300, let mimeType = response.mimeType, mimeType == "application/json" else {
                    return data
                }
                throw URLError(.badServerResponse)
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .map { posts in
                DataModel.init(state: .success(posts))
            }
            .catch {
                Just(DataModel.init(state: .error($0)))
            }
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
    }
}

extension Publisher {
    func delay<S: Scheduler>(_ delayTime:  S.SchedulerTimeType.Stride, retry: Int, scheduler: S) -> AnyPublisher<Self.Output, Self.Failure> {
        func applyDelayAndRetry<Upstream: Publisher, S: Scheduler>(
            upstream: Upstream,
            for interval: S.SchedulerTimeType.Stride,
            scheduler: S,
            count: Int
        ) -> AnyPublisher<Upstream.Output, Upstream.Failure> {
            let share = Publishers.Share(upstream: upstream)
            return share
                .catch { _ in
                    share
                        .delay(for: interval, scheduler: scheduler)
                }
                .retry(count)
                .eraseToAnyPublisher()
        }
        return applyDelayAndRetry(upstream: self, for: delayTime, scheduler: scheduler, count: retry)
    }
}

fileprivate class ViewModel: ObservableObject {
    @Published var result: [Post] = []
    private let dataService = DataService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        dataService.makeApplyAndDelayOperator()
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Api Failed with Error: \(error.localizedDescription)")
                }
            } receiveValue: { posts in
                DispatchQueue.main.async {[weak self] in
//                    self?.result = posts
                }
            }
            .store(in: &cancellables)
    }
}

struct ApplyDelayAndRetryOperatorBootcamp: View {
    private let viewModel = ViewModel()
    var body: some View {
        Text("s")
    }
}

struct ApplyDelayAndRetryOperatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ApplyDelayAndRetryOperatorBootcamp()
    }
}
