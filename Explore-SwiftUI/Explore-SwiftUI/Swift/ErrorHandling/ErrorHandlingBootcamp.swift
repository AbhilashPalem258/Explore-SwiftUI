//
//  ErrorHandlingBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 10/11/22.
//

/*
 Source:
 
 Definition:
 
 Notes:
 - Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.
 - You can use a defer statement even when no error handling code is involved.
 
 */

import SwiftUI

fileprivate enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

fileprivate struct Item {
    let price: Int
    var count: Int
}

fileprivate class VendingMachine {
    var inventory: [String: Item] = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited: Int = 0
    
    func vend(ItemNamed itemName: String) throws {
        guard let item = inventory[itemName] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        var newItem = item
        newItem.count -= 1
        inventory[itemName] = newItem
        
        print("Dispening \(itemName)")
    }
    
    func nourish(with item: String) throws {
        do {
            try vend(ItemNamed: item)
        } catch is VendingMachineError {
            print("Vending Machine Error")
        }
    }
    
    func eat(item: String) throws {
        do {
            try vend(ItemNamed: item)
        } catch VendingMachineError.invalidSelection, VendingMachineError.outOfStock, VendingMachineError.insufficientFunds {
            print("Vending Machine error")
        }
    }
}

fileprivate class ViewModel: ObservableObject {
    let vendingMachine = VendingMachine()
    
    func vendItem(name: String) {
        do {
            try vendingMachine.vend(ItemNamed: name)
        }catch VendingMachineError.invalidSelection {
            print("Handle invalid selection")
        } catch VendingMachineError.outOfStock {
            print("Handle out of stock error")
        } catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded) {
            print("Need More coins: \(coinsNeeded)")
        } catch {
            print("Unexpected non-vending error: \(error)")
        }
    }
    
    func nourishItem(_ name: String) {
        do {
            try vendingMachine.nourish(with: name)
        } catch {
            print("Unexpected non-vending machine error: \(error)")
        }
    }
    
    func eat(item: String) {
        do {
            try vendingMachine.eat(item: item)
        } catch {
            print("Unexpected non-vending machine error: \(error)")
        }
    }
    
}

struct ErrorHandlingBootcamp: View {
    fileprivate let vm = ViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                vm.vendItem(name: "Chips")
            }
    }
}

struct ErrorHandlingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ErrorHandlingBootcamp()
    }
}
