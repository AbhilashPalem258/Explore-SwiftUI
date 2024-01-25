//
//  SearchableBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 17/06/23.
//
import Combine
import SwiftUI

fileprivate struct Fruit: Identifiable {
    var id = UUID()
    var name: String
    let emoji: String

    static let all = [
        Fruit.init(name: "Apple", emoji: "🍎"),
        Fruit.init(name: "Orange", emoji: "🟠"),
        Fruit.init(name: "Lemon", emoji: "🍋"),
        Fruit.init(name: "Kiwi", emoji: "🥝"),
        Fruit.init(name: "Banana", emoji: "🍌"),
        Fruit.init(name: "Pear", emoji: "🍐"),
        Fruit.init(name: "Cherry", emoji: "🍒")
    ]
}

fileprivate struct Token: Identifiable {
    var name: String
    let id = UUID()
}

fileprivate class ViewModel: ObservableObject {
    @Published var allFruits: [Fruit] = Fruit.all
    @Published var filteredFruits: [Fruit] = Fruit.all
    private let allTokens = [Token(name: "Action"), Token(name: "Comedy"), Token(name: "Drama"), Token(name: "Family"), Token(name: "Sci-Fi")]
    @Published var currentTokens = [Token]()
    @Published var suggestedSearches: [Fruit] = [
        Fruit.init(name: "Apple Suggestion", emoji: "🍎"),
        Fruit.init(name: "Orange Suggestion", emoji: "🟠"),
        Fruit.init(name: "Lemon Suggestion", emoji: "🍋"),
    ]

    
    @Published var searchText: String = ""
    private var storage = Set<AnyCancellable>()
    
    var suggestedTokens: [Token] {
        if searchText.starts(with: "#") {
            return allTokens
        } else {
            return []
        }
    }
    
    init() {
        addObservers()
    }
    
    func addObservers() {
        searchTextObserver()
    }
    
    func searchTextObserver() {
        $searchText
            .sink {[weak self] query in
                guard !query.isEmpty else {
                    self?.filteredFruits = Fruit.all
                    return
                }
                self?.filteredFruits = Fruit.all.filter { fruit in
                    fruit.name.contains(query)
                }
            }
            .store(in: &storage)
    }
    
    func refreshFilteredFruits() {
        self.filteredFruits = Fruit.all
    }
}

@available(iOS 16, *)
struct SearchableBootcamp: View {
    
    @StateObject private var vm: ViewModel = .init()
//    init(vm: ViewModel) {
//        self._vm = StateObject(wrappedValue: vm)
//    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.filteredFruits) { fruit in
                    fruitView(fruit)
                }
            }
            .searchable(text: $vm.searchText, tokens: $vm.currentTokens, suggestedTokens: .constant(vm.suggestedTokens), placement: .automatic,  prompt: "Search Fruits") { token in
                Label(token.name, systemImage: "square.and.arrow.up.circle")
            }
            .searchSuggestions {
                ForEach(vm.suggestedSearches) { suggestion in
                    Label(suggestion.name, systemImage: "square.and.arrow.down.on.square.fill")
                }
            }
            .navigationTitle("Fruits")
            .onAppear {
                vm.refreshFilteredFruits()
            }
        }
    }
    
    private func fruitView(_ fruit: Fruit) -> some View {
        HStack {
            Text(fruit.emoji)
            Text(fruit.name)
        }
    }
}

@available(iOS 16, *)
struct SearchableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SearchableBootcamp()
    }
}
