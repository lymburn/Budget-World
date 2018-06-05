//
//  SettingsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let cellId = "cellId"
    let settingNames = ["Choose currency", "Rate us", "Send feedback"]

    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets.zero
        tv.rowHeight = 50
        tv.tableFooterView = UIView()
        return tv
    }()
    
    let slideMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(slideMenuPressed), for: .touchDown)
        return button
    }()
    
    let moreLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.text = "More"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        return label
    }()
}

//MARK: Setup
extension SettingsController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(moreLabel)
        view.addSubview(slideMenu)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        moreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moreLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        slideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        slideMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: moreLabel.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingCell
        cell.settingLabel.text = settingNames[indexPath.row]
        return cell
    }
}

//MARK: Touch events {
extension SettingsController {
    @objc func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
}
