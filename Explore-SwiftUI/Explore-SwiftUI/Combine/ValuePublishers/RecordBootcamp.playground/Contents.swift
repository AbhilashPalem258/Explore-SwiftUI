import Combine
import UIKit


/*
 Source:
 https://www.apeth.com/UnderstandingCombine/publishers/publishersrecord.html
 
 Definition:
 
 Notes:
 */

enum MyError: Error {
    case tooBig
}

let record = Record<Int, MyError>(output: [1, 2, 3, 4, 5], completion: .failure(.tooBig))
print(record.recording)
record.sink { completion in
    if case let .failure(error) = completion {
        print("error \(error)")
    }
} receiveValue: { val in
    print(val)
}


let secondRecording = Record(recording: record.recording)
print("Printing vas")
secondRecording.sink { completion in
    print("completion: \(completion)")
} receiveValue: { val in
    print("values \(val)")
}

// MARK: - Recording values from another publisher and using it
let pub = (1...10).publisher
    .setFailureType(to: Error.self)
    .flatMap { i -> AnyPublisher<Int, Error> in
        if i < 5 {
            return Just(i).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: MyError.tooBig).eraseToAnyPublisher()
        }
    }
var recording = Record<Int, Error>.Recording()
pub.sink { completion in
    recording.receive(completion: completion)
} receiveValue: { val in
    recording.receive(val)
}

Record(recording: recording)
    .sink { completion in
        print("Record 3 completion: \(completion)")
    } receiveValue: { val in
        print("Record 3 value: \(val)")
    }

//
