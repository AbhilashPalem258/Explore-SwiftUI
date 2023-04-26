//
//  OpaqueTypeiCode.swift
//  Explore-Swift
//
//  Created by Abhilash Palem on 10/01/22.
//

import Foundation

enum CardType {
    case gold
    case platinum
}

protocol Card {
    associatedtype CardNumber: CardNumberProtocol
    var type: CardType {get set}
    var limit: Int {get set}
    var number: String {get set}
    func validateCardNumber(number: CardNumber)
}

protocol CardNumberProtocol {
    
}
extension String: CardNumberProtocol {
    
}

struct VisaCard: Card {
    var type: CardType = .gold
    
    var limit: Int = 1000000
    
    var number: String = "4141 5356 6783 9101"
    
    func validateCardNumber(number: String) {
        
    }
    
    typealias CardNumber = String
}

struct MasterCard: Card {
    var type: CardType = .platinum
    
    var limit: Int = 100000
    
    var number: String = "4121 5356 6783 9101"
    
    func validateCardNumber(number: String) {
        
    }
    
    typealias CardNumber = String
}

final class User {
    func getLoanEligibility() -> Bool {
        getUserCard().limit >= getLoanEligibilityCard().limit
    }
    
    func getUserCard() -> some Card {
        MasterCard()
    }
    
    func getLoanEligibilityCard() -> some Card {
        VisaCard()
    }
}
