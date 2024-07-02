//
//  DetailViewController.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 02.07.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol?
    
    var imageMovie: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()
    
    private let kinopoiskLabel = CustomLabel(text: "Кинопоиск", size: 17, color: .white)
     
     var kinopoiskChartLabel = CustomLabel(text: "", size: 17, color: .white)
     
     private let imdbLabel = CustomLabel(text: "IMBD", size: 17, color: .white)
     
     var imdbChartLabel = CustomLabel(text: "IMBD", size: 17, color: .white)
     
     var movieNameRuLabel = CustomLabel(text: "", size: 22, color: .white)
     
     var movieNameEnLabel = CustomLabel(text: "", size: 18, color: .gray)
     
     var descriptionLabel = CustomLabel(text: "", textAlignment: .justified, size: 16, color: .white, numberOfLines: 0)
     
     private let productionYearLabel = CustomLabel(text: "Год производства:", size: 17, color: .gray)
     
     var productionYearInfoLabel = CustomLabel(text: "", size: 17, color: .white)
     
     private let durationLabel = CustomLabel(text: "Продолжительность:", size: 17, color: .gray)
     
     var durationInfoLabel = CustomLabel(text: "", size: 17, color: .white, numberOfLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getFilm()
    }
    
    private func setupUI() {
         view.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
         self.view.addSubview(imageMovie)
         self.view.addSubview(kinopoiskLabel)
         self.view.addSubview(kinopoiskChartLabel)
         self.view.addSubview(imdbLabel)
         self.view.addSubview(imdbChartLabel)
         self.view.addSubview(movieNameRuLabel)
         self.view.addSubview(movieNameEnLabel)
         self.view.addSubview(descriptionLabel)
         self.view.addSubview(productionYearLabel)
         self.view.addSubview(productionYearInfoLabel)
         self.view.addSubview(durationLabel)
         self.view.addSubview(durationInfoLabel)
        
        imageMovie.snp.makeConstraints { make in
            make.height.equalTo(240)
            make.width.equalTo(170)
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(30)
        }
        
        kinopoiskLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.equalTo(imageMovie.snp.right).offset(60)
        }
        
        kinopoiskChartLabel.snp.makeConstraints { make in
            make.top.equalTo(kinopoiskLabel.snp.bottom).offset(10)
            make.left.equalTo(imageMovie.snp.right).offset(95)
        }
        
        imdbLabel.snp.makeConstraints { make in
            make.top.equalTo(kinopoiskChartLabel.snp.bottom).offset(30)
            make.left.equalTo(imageMovie.snp.right).offset(85)
        }
        
        imdbChartLabel.snp.makeConstraints { make in
            make.top.equalTo(imdbLabel.snp.bottom).offset(10)
            make.left.equalTo(imageMovie.snp.right).offset(95)
        }
        
        movieNameRuLabel.snp.makeConstraints { make in
            make.top.equalTo(imageMovie.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        movieNameEnLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameRuLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameEnLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        productionYearLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
        }
        
        productionYearInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(productionYearLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(productionYearInfoLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
        }
        
        durationInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(durationLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
        }
     }
}

extension DetailViewController: DetailViewProtocol {
    func getFilmDetail(film: Movie) {
        kinopoiskChartLabel.text = String(describing: film.ratingKinopoisk ?? 0.0)
        imdbChartLabel.text = String(describing: film.ratingImdb ?? 0.0)
        movieNameRuLabel.text = film.nameRu ?? ""
        movieNameEnLabel.text = film.nameOriginal ?? ""
        descriptionLabel.text = film.description ?? ""
        productionYearInfoLabel.text = String(describing: film.year ?? 0)
        durationInfoLabel.text = "\(String(describing: film.filmLength ?? 0)) мин."
        
        let url = URL(string: film.posterUrl ?? "")
        DispatchQueue.global().async {
            let image = ImageManager.shared.fetchImage(from: url)
            DispatchQueue.main.async {
                self.imageMovie.image = UIImage(data: image!)
            }
        }
    }
}

