//
//  TaskConcurrency.swift
//  Task1
//
//  Created by Abhilash Palem on 23/06/22.
//

import SwiftUI
/*
 - Just because we are in a task and using await and in a asynchronous environment does not necessarily mean that we are going to be on a different thread other than the Main thread
 */

struct TaskConcurrency: View {
    
    @State var images = [UIImage]()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let url = URL(string: "https://picsum.photos/300")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { img in
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
//                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async let :)")
            .onAppear {
                Task {
                    do {
//                        async let fetchImage1 = fetchImage()
//                        async let fetchImage2 = fetchImage()
//                        async let fetchImage3 = fetchImage()
//                        async let fetchImage4 = fetchImage()
//
//                        let (image1, image2, image3, image4) = try await (fetchImage1, fetchImage2, fetchImage3, fetchImage4)
//
//                        self.images.append(contentsOf: [image1, image2, image3, image4])
//
                        let image1 = try await fetchImage()
                        images.append(image1)

                        let image2 = try await fetchImage()
                        images.append(image2)

                        let image3 = try await fetchImage()
                        images.append(image3)

                        let image4 = try await fetchImage()
                        images.append(image4)
                    } catch {
                        print("Error while downloading image: \(error)")
                    }
                }
            }
        }
    }
    
    func fetchImage() async throws -> UIImage {
//        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let img = UIImage(data: data) {
                return img
            } else {
                throw URLError(.badURL)
            }
//        } catch {
//            throw error
//        }
    }
}

struct TaskConcurrency_Previews: PreviewProvider {
    static var previews: some View {
        TaskConcurrency()
    }
}
