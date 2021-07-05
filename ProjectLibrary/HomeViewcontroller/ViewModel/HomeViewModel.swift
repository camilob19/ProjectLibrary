//
//  HomeViewModel.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 3/07/21.
//

import Foundation

class HomeViewModel {
    var models: [Book] = []
    var filteredModels: [Book] = []
    var didUpdateModels: (() -> Void)?
    private let loader: BookLoaderProtocol
    
    init (loader: BookLoaderProtocol) {
        self.loader = loader
    }
    
    func getBooksInformation() {
        loader.getCountriesFromServer { result in
            switch result {
            case .success(let books):
                self.models = books
                self.filteredModels = books
                self.didUpdateModels?()
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
    func search(using keyword: String) {
        guard !keyword.isEmpty else {
            filteredModels = models
            didUpdateModels?()
            return
        }
        filteredModels = models.filter({ $0.title.lowercased().contains(keyword.lowercased())})
        didUpdateModels?()
    }
}
