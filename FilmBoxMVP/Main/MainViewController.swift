//
//  MainViewController.swift
//  FilmBoxMVP
//
//  Created by Максим Зыкин on 30.06.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    let cellID = ""
    
    var presenter: MainViewPresenterProtocol!
    
    private var isSearch = true
    
    private let lableApp: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 46, weight: .bold)
        label.textColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
        label.text = "FilmBox"
    return label
    }()
    
    private let serchTextField = CustomTextField(filedTypr: .search)
    
    private let buttonSerch = CustomButtons(title: "Поиск", fontSize: .med)
    
    private var table: UITableView = {
        let tableView = UITableView()
        tableView.sectionHeaderTopPadding = 0
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        serchTextField.delegate = self
        setupUI()
        presenter.getTopFilms()
        addTarget()
    }
    
    func addTarget() {
        buttonSerch.addTarget(self, action: #selector(tabSerch), for: .touchUpInside)
    }
    
    @objc func tabSerch() {
        guard serchTextField.text != "" else {
            self.isSearch = false
            presenter.getTopFilms()
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        return }
        
        guard let filmSerch = serchTextField.text else { return }
        self.isSearch = true
        presenter.searchFilm(keyword: filmSerch)
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 255/255)
        self.view.addSubview(lableApp)
        self.view.addSubview(serchTextField)
        self.view.addSubview(buttonSerch)
        self.view.addSubview(table)
        
        lableApp.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalTo(20)
        }
        
        serchTextField.snp.makeConstraints { make in
            make.top.equalTo(lableApp.snp_bottomMargin).inset(-30)
            make.left.equalTo(20)
            make.right.equalTo(-120)
            make.height.equalTo(40)
        }
        
        buttonSerch.snp.makeConstraints { make in
            make.top.equalTo(lableApp.snp_bottomMargin).inset(-30)
            make.left.equalTo(serchTextField.snp_rightMargin).inset(-20)
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(buttonSerch.snp_bottomMargin).inset(-30)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.films.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MainTableViewCell.cellID, for: indexPath) as? MainTableViewCell
        if let film = presenter?.films[indexPath.row] {
            cell?.configure(model: film)
        }
        return cell ?? UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .darkGray
            header.tintColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 255/255)
            header.textLabel?.font = UIFont(name: "Helvetica-Regular", size: 15)
            header.textLabel?.numberOfLines = 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearch {
            return "Результаты по запросу: \(serchTextField.text ?? "")"
        } else {
            return "Популярные фильмы "
        }
    }
}


extension MainViewController: MainViewProtocol{
    func getFilms() {
        table.reloadData()
    }
}
