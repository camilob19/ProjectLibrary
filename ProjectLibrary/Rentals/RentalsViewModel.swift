//
//  RentalsViewModel.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//

import Foundation

class RentalsViewModel {
    var models: [Book] = []
    var didUpdateModels: (() -> Void)?
    private let loader: BookLoaderProtocol
    private let coreDataManager: CoreDataManager
    
    init (loader: BookLoaderProtocol,
          coreDataManager: CoreDataManager) {
        self.loader = loader
        self.coreDataManager = coreDataManager
    }
    
    private func filterRentals(books: [Book]) -> [Book] {
        let filteredBook = books.filter { book -> Bool in
            return coreDataManager.find(id: book.id, in: .rentals)
        }
        return filteredBook
    }
    
    func getBooksInformation() {
        loader.getCountriesFromServer { result in
            switch result {
            case .success(let books):
                self.models = self.filterRentals(books: books)
                self.didUpdateModels?()
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
}
