//
//  FutureDeferredBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 27/07/22.
//

import CoreLocation
import Combine
import Foundation
import MapKit
import SwiftUI

/*
 Source:
 https://www.apeth.com/UnderstandingCombine/publishers/publishersfuture.html
 
 Definition:
 A Future is a publisher that generalizes the sort of thing a data task publisher does: it launches some asynchronous task, and when it is subscribed to and the task has completed (or there is an error), it publishes.
 
 A Deferred publisher is extremely simple: it is initialized with a function that returns another publisher, but it doesn’t run that function, and thus doesn’t create that publisher, until it is subscribed to
 
 Notes:
 - The promise function takes one parameter: a Result. As you know, a Result is an enum with a .success case and a .failure case
 
 - However, there’s a potential problem. What happens if we don’t attach a Sink to future? The answer is that the Future’s function runs anyway. We go out on the network with our geocoder and try to get a coordinate for our address, even though we have no subscriber. That is not the way a data task publisher behaves; it waits to start operating until it actually has a subscriber. If we want our Future to behave like that, we can wrap it in a Deferred publisher.
 */


class FutureDefferedBootcampViewModel: ObservableObject {
    @Published var address: String = ""
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var taskState: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
//    func reverseGeocodeAddressCompletionHandler() {
//        CLGeocoder().geocodeAddressString(address) { placemarks, error in
//            guard let placemarks = placemarks else {
//                return
//            }
//            let placemark = placemarks[0]
//            let mPlacemark = MKPlacemark(placemark: placemark)
//            let coord = mPlacemark.coordinate
//            self.latitude = coord.latitude
//            self.longitude = coord.longitude
//        }
//    }
    
    func reverseGeocode() {
        /*
        //Future Problem: It runs even there is no subscriber
        reverseGeocodeFuture()
            .map { coords -> CLLocationCoordinate2D in
                print(coords)
                return coords
            }
         */
        
        // Deffered Example, solving future problem
        reverseGeocodeDeffered()
            .map { coords -> CLLocationCoordinate2D in
                print(coords)
                return coords
            }
            .sink {[weak self] completion in
                if case .failure(_) = completion {
                    self?.taskState = "Failed"
                } else {
                    self?.taskState = "Success"
                }
            } receiveValue: {[weak self] coords in
                self?.latitude = coords.latitude
                self?.longitude = coords.longitude
            }
            .store(in: &cancellables)

    }
    
    enum GeocodeError: Error {
        case oops
    }
    
    func reverseGeocodeDeffered() -> Deferred<Future<CLLocationCoordinate2D, Error>> {
        return Deferred {
            self.reverseGeocodeFuture()
        }
    }
    
    func reverseGeocodeFuture() -> Future<CLLocationCoordinate2D, Error> {
        return Future<CLLocationCoordinate2D, Error> {[weak self] promise in
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(self?.address ?? "") { placemarks, error in
                let result = Result<CLLocationCoordinate2D, Error> {
                    if let error = error {
                        throw error
                    }
                    guard let placemarks = placemarks else {
                        throw GeocodeError.oops
                    }
                    let placemark = placemarks[0]
                    let mPlacemark = MKPlacemark(placemark: placemark)
                    let coords = mPlacemark.coordinate
                    return coords
                }
                return promise(result)
            }
        }
    }
    
}

struct FutureDefferedBootcamp: View {
    
    @StateObject private var vm = FutureDefferedBootcampViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                TextField("Enter Address", text: $vm.address)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.bottom, 20)
                
                
                Button {
                    vm.reverseGeocode()
                } label: {
                    Text("Geocode".uppercased())
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding()
                        .background(.brown)
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Latitude:")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Text("\(vm.latitude)")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                }
                
                HStack {
                    Text("Longitude:")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))

                    Text("\(vm.longitude)")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                }
                
                if !vm.taskState.isEmpty {
                    Text(vm.taskState)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(vm.taskState == "Success" ? .green : .red)
                        .padding(.horizontal)
                        .padding()
                        .background(.secondary)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()

        }
    }
    

}

struct FutureDefferedBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FutureDefferedBootcamp()
    }
}
