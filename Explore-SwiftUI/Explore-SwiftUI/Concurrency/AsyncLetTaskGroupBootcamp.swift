//
//  AsyncLetTaskGroupBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 29/06/22.
//

import Foundation
import SwiftUI

fileprivate struct DataManager {
    func fetchImagesUsingAsyncLet() async -> [UIImage] {
        async let fetchImage1 = fetchImage(urlStr: "https://picsum.photos/300")
        async let fetchImage2 = fetchImage(urlStr: "https://picsum.photos/300")
        async let fetchImage3 = fetchImage(urlStr: "https://picsum.photos/300")
        async let fetchImage4 = fetchImage(urlStr: "https://picsum.photos/300")
        async let fetchImage5 = fetchImage(urlStr: "https://picsum.photos/300")
        
        let (image1, image2, image3, image4, image5) = await (try? fetchImage1, try? fetchImage2, try? fetchImage3, try? fetchImage4, try? fetchImage5)
        
        return [image1, image2, image3, image4, image5].compactMap{$0}
    }
    
    func fetchImagesUsingTaskGroup() async throws -> [UIImage] {
        let urlStrs = [
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300"
        ]

        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var result = [UIImage]()

            for url in urlStrs {
                group.addTask {
                    try? await fetchImage(urlStr: url)
                }
            }
            
            for try await image in group {
                if let img = image {
                    result.append(img)
                }
            }
            
            return result
        }
    }
    
    private func fetchImage(urlStr: String) async throws -> UIImage {
        let url = URL(string: urlStr)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class AsyncLetTaskGroupBootcampViewModel: ObservableObject {
    @Published var images = [UIImage]()
    private let dataManager = DataManager()
    
    func fetchImages() async {
//        let images = await dataManager.fetchImagesUsingAsyncLet()
//        await MainActor.run {
//            self.images = images
//        }
        let images = try? await dataManager.fetchImagesUsingTaskGroup()
        if let images = images {
            await MainActor.run {
                self.images = images
            }
        }
    }
}

struct AsyncLetTaskGroupBootcamp: View {
    
    @StateObject var viewModel = AsyncLetTaskGroupBootcampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImages()
            }
        }
    }
}

struct AsyncLetTaskGroupBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLetTaskGroupBootcamp()
    }
}
