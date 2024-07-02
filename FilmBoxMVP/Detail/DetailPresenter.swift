//
//  DetailPresenter.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func getFilmDetail(film: Movie)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, network: NetworkDataFetchProtocol, film: Movie)
    func getFilm()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let network: NetworkDataFetchProtocol
    var film: Movie
    
    required init(view: any DetailViewProtocol, network: any NetworkDataFetchProtocol, film: Movie) {
        self.view = view
        self.network = network
        self.film = film
    }
    
    func getFilm() {
        self.view?.getFilmDetail(film: film)
    }
    
}
