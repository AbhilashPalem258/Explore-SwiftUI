//
//  AsyncImageGrid.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 31/12/22.
//

import SwiftUI

fileprivate struct ImageData: Identifiable {
    let id: Int
    let urlStr = "https://picsum.photos/200"
}

fileprivate class ViewModel: ObservableObject {
    @Published var imageUrls = [ImageData]()
    private var count = 10
    
    func addItem() {
        count += 1
        imageUrls.append(ImageData(id: count))
    }
    
    func deleteItem() {
        _ = imageUrls.popLast()
    }
    
    func fetchImageData() {
        for i in 1...count {
            imageUrls.append(ImageData(id: i))
        }
    }
}

struct AsyncImageGrid: View {
    
    @StateObject private var vm = ViewModel()
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(vm.imageUrls) { imgData in
//                        AsyncImage(
//                            url: URL(string: imgData.urlStr)) { returnedImage in
//                                returnedImage
//                                    .resizable()
//                                    .scaledToFit()
//                                    .cornerRadius(10.0)
//
//                            } placeholder: {
//                                ProgressView()
//                            }
                        AsyncImage(url: URL(string: imgData.urlStr)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let returnedImage):
                                returnedImage
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10.0)
                            case .failure(let error):
                                Image(systemName: "questionmark")
                            default:
                                Image(systemName: "questionmark")
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .onAppear {
                    vm.fetchImageData()
                }
                .navigationTitle("Async Image")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            vm.deleteItem()
                        } label: {
                            Image(systemName: "minus.diamond.fill")
                        }
                        .accentColor(.black)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            vm.addItem()
                        } label: {
                            Image(systemName: "plus.rectangle.fill.on.rectangle.fill")
                        }
                        .accentColor(.black)
                    }
                }
            }
        }
    }
}

struct AsyncImageGrid_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageGrid()
    }
}
