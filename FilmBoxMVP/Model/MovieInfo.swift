//
//  MovieInfo.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import UIKit

struct Movie: Decodable, Equatable {
    let filmId: Int?
    let nameRu: String?
    let nameOriginal: String?
    let posterUrl: String?
    let ratingKinopoisk: Double?
    let ratingImdb: Double?
    let year: Int?
    let filmLength: Int?
    let description: String?
}
