//
//  AsyncPublisherBootcamp.swift
//  Task1
//
//  Created by Abhilash Palem on 27/06/22.
//

import Foundation
import SwiftUI
import Combine

class AsyncPublisherDataManager {
    
    @Published var myData: [String] = []
    
    
    func fetchDataFromDB() async {
        myData.append(contentsOf: ["Apple", "Banana"])
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append(contentsOf: ["Tiger", "Lion"])
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append(contentsOf: ["Box", "Tiffin"])
    }
}

class AsyncPublisherBootcampViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    let dataManager = AsyncPublisherDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
//        dataManager.$myData
//            .receive(on: DispatchQueue.main, options: nil)
//            .sink { dataArr in
//                self.dataArray = dataArr
//            }
//            .store(in: &cancellables)
        Task {
            for await arr in dataManager.$myData.values {
                await MainActor.run {
                    self.dataArray = arr
                }
            }
        }
    }
    
    func fetchData() async {
        await dataManager.fetchDataFromDB()
    }
}

struct AsyncPublisherBootcamp: View {
    
    @StateObject var vm = AsyncPublisherBootcampViewModel()
    
    var body: some View {
        VStack {
            ForEach(vm.dataArray, id: \.self) { item in
                Text(item)
            }
        }
        .task {
            await vm.fetchData()
        }
    }
}

struct AsyncPublisherBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisherBootcamp()
    }
}
