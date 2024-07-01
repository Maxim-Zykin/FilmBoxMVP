//
//  MainTableViewCell.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
   static let cellID = "films"
    
    let poster: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()
    
    let nameMovie: UILabel! = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    func configure(model: MoviesSearch) {
        nameMovie.text = model.nameRu
        let url = URL(string: model.posterUrl ?? "")
        DispatchQueue.global().async {
            let image = ImageManager.shared.fetchImage(from: url)
            DispatchQueue.main.async {
                self.poster.image = UIImage(data: image!)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(poster)
        contentView.addSubview(nameMovie)
        contentView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        
        poster.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(15)
            make.height.equalTo(120)
            make.width.equalTo(90)
        }
        
        nameMovie.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(poster.snp_centerYWithinMargins)
            make.left.equalTo(poster.snp_leftMargin).inset(90)
            make.right.equalTo(-5)
        }
    }
}
