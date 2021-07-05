//
//  BookLoader.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 3/07/21.
//

import Foundation
import Alamofire

enum HTTPClientError: Error {
    case serviceError
    case errorParser
}

protocol BookLoaderProtocol {
    func getCountriesFromServer(completion: @escaping (Result<[Book], HTTPClientError>) -> Void)
}

class BookLoader: BookLoaderProtocol {
    
    let allBooksURL = "https://private-59a7d9-iostrainingapi.apiary-mock.com/books"
    
    func getCountriesFromServer(completion: @escaping (Result<[Book], HTTPClientError>) -> Void) {
        
        AF.request(allBooksURL).responseJSON { response in
            guard let bookData = response.data else {
                completion(.failure(.errorParser))
                return
            }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Book].self, from: bookData)
                completion(.success(items))
            } catch {
                completion(.failure(.errorParser))
            }
            
        }
    }
}
