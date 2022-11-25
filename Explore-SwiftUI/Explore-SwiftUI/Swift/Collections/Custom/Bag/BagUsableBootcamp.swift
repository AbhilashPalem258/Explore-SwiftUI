//
//  BagUsableBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 21/11/22.
//

import SwiftUI

fileprivate class BagElement: Hashable, CustomStringConvertible {
    let color: UIColor
    init(color: UIColor) {
        self.color = color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.color.hashValue)
    }
    
    static func == (lhs: BagElement, rhs: BagElement) -> Bool {
        lhs.color == rhs.color
    }
    
    var description: String {
        switch self.color {
        case .red:
            return "Red"
        case .brown:
            return "Brown"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        default:
            return "UnKnown"
        }
    }
}

fileprivate class ViewModel: ObservableObject {
    
    private let red = BagElement(color: .red)
    private let green = BagElement(color: .green)
    private let blue = BagElement(color: .blue)
    private let brown = BagElement(color: .brown)
    
    init() {
        var bag: Bag = [
            red,
            red,
            green,
            blue
        ]
        
        print(bag)
        
        bag.add(brown)
        print(bag)
        
        do {
            try bag.remove(red)
            print(bag)
        } catch {
            print(error)
        }
        
        for element in bag {
            print("1 \(element)")
        }
        for element in bag {
            print("2 \(element)")
        }
    }
}

struct BagUsableBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BagUsableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BagUsableBootcamp()
    }
}
