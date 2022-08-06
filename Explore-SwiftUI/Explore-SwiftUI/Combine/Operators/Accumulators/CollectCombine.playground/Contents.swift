import Combine
import UIKit
import Foundation

//Example1
[
    "https://picsum.photos/200",
    "https://picsum.photos/200",
    "https://picsum.photos/200"
]
    .map(URL.init(string:))
    .compactMap{$0}
    .map(URLSession.shared.dataTaskPublisher(for:))
    .publisher
    .flatMap(maxPublishers: .max(1)) {
        $0.replaceError(with: (Data(), URLResponse()))
    }
    .collect()
    .sink { item in
        print(item)
    }


[1,2,3].publisher
    .collect(2)
    .sink { val in
        print(val)
    }


