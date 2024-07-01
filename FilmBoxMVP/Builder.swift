//
//  Builder.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import UIKit

protocol Builder {
    static func createMainViewController() -> UIViewController
    //static func detailViewController(film: Movie?) -> UIViewController
}

class ModelBuilder: Builder {
    
    static func createMainViewController() -> UIViewController {
        let view = MainViewController()
        let network = NetworkDataFetch()
        let presenter = MainPresenter(view: view, network: network)
        view.presenter = presenter
        return view
    }
    
//    static func detailViewController(film: Movie?) -> UIViewController {
//        <#code#>
//    }
    
    
}
