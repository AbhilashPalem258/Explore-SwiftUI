//
//  FlightActor.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 23/04/23.
//

import SwiftUI
// https://www.youtube.com/watch?v=6MK9mJ319bk

fileprivate class FlightSerialQ {
    let company = "Vistara"
    var availableSeats = ["1A", "1B", "1C"]
    
    private var lock = DispatchQueue(label: "lock")
    
    func bookSeat() -> String {
        lock.sync(flags: .barrier) {
            let seat = availableSeats.removeFirst()
            return seat
        }
    }
    
    func getAvailableSeats() -> [String] {
        lock.sync {
            availableSeats
        }
    }
}

fileprivate class FlightConcurrentQ {
    let company = "Vistara"
    var availableSeats = ["1A", "1B", "1C"]
    
    private var lock = DispatchQueue(label: "lock", qos: .userInitiated, attributes: [.concurrent])
    
    func bookSeat() -> String {
        lock.sync(flags: .barrier) {
            let seat = availableSeats.removeFirst()
            return seat
        }
    }
    
    func getAvailableSeats() -> [String] {
        lock.sync {
            availableSeats
        }
    }
}

fileprivate actor FlightActorEx {
    nonisolated var company: String {
        "Vistara"
    }
    
    var availableSeats = ["1A", "1B", "1C"]
        
    func bookSeat() -> String {
        let seat = availableSeats.removeFirst()
        return seat
    }
    
    func getAvailableSeats() -> [String] {
        availableSeats
    }
}


fileprivate class ViewModel {
    func executeFlightIssue() {
        let flight = FlightSerialQ()
//        let flight = FlightConcurrentQ()
        
        let queue1 = DispatchQueue(label: "label1")
        let queue2 = DispatchQueue(label: "label2")

        queue2.async {
            print("Available seats for booking: \(flight.getAvailableSeats())")
        }
        
        
        queue1.async {
            let bookedSeat = flight.bookSeat()
            print("Booked seat: \(bookedSeat)")
        }
        
    }
    
    func executeFlightsActor() {
        let flight = FlightActorEx()
        
        print(flight.company)
        Task {
            print("Booked seat ", await flight.bookSeat())
            print("Available seats ", await flight.availableSeats)
        }
    }
}

struct FlightActor: View {
    private let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
//                vm.executeFlightIssue()
                vm.executeFlightsActor()
            }
    }
}

struct FlightActor_Previews: PreviewProvider {
    static var previews: some View {
        FlightActor()
    }
}
