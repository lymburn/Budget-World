//
//  SavingsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-01.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

class SavingsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Savings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        
        tableView.register(SavingCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        setupViews()
        savings = SavingManager.fetchSavings()
    }
    
    var savings: [Saving]!
    let cellId = "cellId"
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets.zero
        tv.rowHeight = 80
        return tv
    }()
    
    let slideMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(slideMenuPressed), for: .touchDown)
        return button
    }()
    
    let savingsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.text = "Savings"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        return label
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create New Saving", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 17)
        button.addTarget(self, action: #selector(createSavingPressed), for: .touchDown)
        return button
    }()
}

//MARK: Setup
extension SavingsController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(savingsLabel)
        view.addSubview(createButton)
        view.addSubview(slideMenu)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        savingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        savingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        savingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        savingsLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        slideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        slideMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: savingsLabel.bottomAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: createButton.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

//MARK: Table view data source and delegate
extension SavingsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SavingCell
        return cell
    }
}

//MARK: Touch events
extension SavingsController {
    @objc func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    @objc func createSavingPressed() {
        let createController = CreateSavingController()
        let nav = UINavigationController(rootViewController: createController)
        self.present(nav, animated: true, completion: nil)
    }
}
