//
//  AsyncSequenceBootcamp.swift
//  Task1
//
//  Created by Abhilash Palem on 27/06/22.
//

import Foundation
import SwiftUI

fileprivate struct ImageSequence: AsyncSequence {
    typealias AsyncIterator = ImageIterator
    typealias Element = Data
    
    
    private let count: Int
    private let iterator: ImageIterator
    
    init(count: Int) {
        self.count = count
        self.iterator = ImageIterator(count: count)
    }
    
    func makeAsyncIterator() -> ImageIterator {
        return self.iterator
    }
}

fileprivate struct ImageIterator: AsyncIteratorProtocol {
    typealias Element = Data
    private var current = 0
    private let url = URL(string: "https://picsum.photos/300")!
    
    private let limit: Int
    init(count: Int) {
        self.limit = count
    }
    
    mutating func next() async throws -> Data? {
        guard current < limit else {
            return nil
        }
        
        self.current += 1
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            return data
        } catch {
            throw error
        }
    }
    
}

class AsyncSequenceBootcampViewModel: ObservableObject {
    @Published var imageCollection = [UIImage]()
    
    func fetchImagesFromApi(count: Int) async {
        do {
            for try await imageData in ImageSequence(count: count) {
                await MainActor.run {
                    self.imageCollection.append(UIImage(data: imageData)!)
                }
            }
        } catch {
            print("Error while downloading images")
        }
    }
}

struct AsyncSequenceBootcamp: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var viewModel = AsyncSequenceBootcampViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.imageCollection, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .task {
            await viewModel.fetchImagesFromApi(count: 10
            )
        }
    }
}

struct AsyncSequenceBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncSequenceBootcamp()
    }
}
