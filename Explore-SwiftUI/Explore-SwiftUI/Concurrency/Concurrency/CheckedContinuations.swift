//
//  CheckedContinuations.swift
//  Task1
//
//  Created by Abhilash Palem on 25/06/22.
//

import Foundation
import SwiftUI

struct CheckedContinuationDataManager {
    func fetchImage(from url: URL) async throws -> UIImage {
        try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let err = error {
                    continuation.resume(throwing: err)
                    return
                }
                
                if let statuscode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statuscode), let data = data, let image = UIImage(data: data) {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func fetchImageFromDatabase() async -> UIImage {
        await withCheckedContinuation { continuation in
            fetchImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
    
    func fetchImageFromDatabase(completion: @escaping (_ image: UIImage) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            completion(UIImage(systemName: "heart.fill")!)
        }
    }
}

class CheckedContinuationViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let dataManager = CheckedContinuationDataManager()
    
    func fetchImage() async {
        do {
            let image = try await dataManager.fetchImage(from: URL(string: "https://picsum.photos/300")!)
            await MainActor.run(body: {
                self.image = image
            })
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchImageFromDB() async {
        let image = await dataManager.fetchImageFromDatabase()
        await MainActor.run(body: {
            self.image = image
        })
    }
}

struct CheckedContinuationBootcamp: View {
    
    @StateObject var viewModel = CheckedContinuationViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImageFromDB()
        }
    }
}

struct CheckedContinuationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuationBootcamp()
    }
}
