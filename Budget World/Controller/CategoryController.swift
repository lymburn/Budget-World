//
//  BaseCategoryController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var transactionType: TransactionType!
    let cellId = "cellId"
    let incomeCategories = ["Salary", "Investment", "Sale"]
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.rowHeight = 50
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = UIView()
        return tb
    }()
}

//MARK: Setup
extension CategoryController {
    fileprivate func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
