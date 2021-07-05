//
//  WishListViewModel.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//

import Foundation

class WishListViewModel {
    var models: [Book] = []
    var didUpdateModels: (() -> Void)?
    private let loader: BookLoaderProtocol
    private let coreDataManager: CoreDataManager
    
    init (loader: BookLoaderProtocol,
          coreDataManager: CoreDataManager) {
        self.loader = loader
        self.coreDataManager = coreDataManager
    }
    
    private func filterFavorites(books: [Book]) -> [Book] {
        let filteredBook = books.filter { book -> Bool in
            return coreDataManager.find(id: book.id, in: .favorites)
        }
        return filteredBook
    }
    
    func getBooksInformation() {
        loader.getCountriesFromServer { result in
            switch result {
            case .success(let books):
                self.models = self.filterFavorites(books: books)
                self.didUpdateModels?()
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
}
