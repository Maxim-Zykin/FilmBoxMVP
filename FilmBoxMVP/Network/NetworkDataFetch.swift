//
//  NetworkDataFetch.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import Foundation

protocol NetworkDataFetchProtocol {
   static func fetchMovies(urlString: String, responce: @escaping (MovieCellModel?, Error?) -> ())
}

class NetworkDataFetch: NetworkDataFetchProtocol {
    
  static func fetchMovies(urlString: String, responce: @escaping (MovieCellModel?, Error?) -> ()) {
        
        NetworkRequest.requestDataFetch(url: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(MovieCellModel.self, from: data)
                    responce (json, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
    
    static func fetchMovieDetail(urlString: String, responce: @escaping (Movie?, Error?) -> ()) {
        
        NetworkRequest.requestDataFetch(url: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(Movie.self, from: data)
                    responce (json, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}

