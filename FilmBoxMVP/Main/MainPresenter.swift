//
//  MainPresenter.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func getFilms()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, network: NetworkDataFetchProtocol)
    func getTopFilms()
    func searchFilm(keyword: String)
    var films: [MoviesSearch] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    var films: [MoviesSearch] = []
    
    let network: NetworkDataFetchProtocol
    
    required init(view: MainViewProtocol, network: NetworkDataFetchProtocol) {
        self.view = view
        self.network = network
    }
    
    func getTopFilms() {
        let url = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
         NetworkDataFetch.fetchMovies(urlString: url) { [weak self] popularMovieCellModel,
             error in
             if error == nil {
                 guard let popularMovieCellModel = popularMovieCellModel else { return }
                 self?.films = popularMovieCellModel.films
                 self?.view?.getFilms()
                 print("успех")
             } else {
                 print(error!.localizedDescription)
             }
         }
    }
    
    func searchFilm(keyword: String) {
        let url = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(keyword)"
         NetworkDataFetch.fetchMovies(urlString: url) { [weak self] popularMovieCellModel,
             error in
             if error == nil {
                 guard let popularMovieCellModel = popularMovieCellModel else { return }
                 self?.films = popularMovieCellModel.films
                 self?.view?.getFilms()
             } else {
                 print(error!.localizedDescription)
             }
         }
    }
}
