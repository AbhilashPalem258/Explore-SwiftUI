//
//  SplittersUsageIntro.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 06/08/22.
//
import Combine
import Foundation
import SwiftUI

fileprivate struct DataService {
    func makeSplitterPublisher() {
//        [1,2,3].publisher
//            .map {
//                Just($0)
//                    .delay(for: 1, scheduler: DispatchQueue.main)
//            }
//            .flatMap(maxPublishers: .max(1)) { $0 }
    }
}

class SplittersUsageIntroBootcampViewModel: ObservableObject {
    @Published var items = [Int]()
    
    func startPublishing() {
        
    }
}

struct SplittersUsageIntroBootcamp: View {
    var body: some View {
        Text("SplittersUsageIntroBootcamp")
    }
}

struct SplittersUsageIntroBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SplittersUsageIntroBootcamp()
    }
}
