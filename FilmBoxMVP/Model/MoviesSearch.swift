//
//  MoviesSearch.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import UIKit

struct MovieCellModel: Decodable, Equatable {
    let films: [MoviesSearch]
}

struct MoviesSearch: Decodable, Equatable {
    let filmId: Int?
    let nameRu: String?
    let nameOriginal: String?
    let posterUrl: String?
    
}
