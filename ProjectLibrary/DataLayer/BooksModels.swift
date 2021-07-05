//
//  BooksModels.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 3/07/21.
//

import Foundation

struct Book: Codable {
    var image: String
    var title: String
    var id: Int
    var author: String
    var year: String
    var status: String
    var genre: String
}
