//
//  BaseCategoryController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol CategoryDelegate: class {
    func categorySelected(categoryName: String, categoryType: CategoryType)
}

class CategoryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        chooseCategoryNames()
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    weak var delegate: CategoryDelegate? = nil
    var transactionType: TransactionType!
    let cellId = "cellId"
    var categoryNames : [String]!
    var categoryIcons : [String]!
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.rowHeight = 50
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = UIView()
        tb.backgroundColor = .clear
        tb.separatorColor = .white
        return tb
    }()
}

//MARK: Setup
extension CategoryController {
    fileprivate func setupViews() {
        navigationItem.title = "Category"
        view.addGradientWithColor(primary: UIColor.rgb(red: 52, green: 232, blue: 158), secondary: UIColor.rgb(red: 15, green: 52, blue: 67))
        view.addSubview(tableView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func chooseCategoryNames() {
        //Choose categories to display depending whether it's income or expenses
        if transactionType == .income {
            categoryNames = ["Salary", "Investment", "Sale"]
            categoryIcons = ["Salary", "Investment", "Sale"]
        } else {
            categoryNames = ["General", "Eating out", "Housing", "Fuel", "Transportation", "Entertainment", "Groceries", "Clothing","Education", "Hobbies", "Medical"]
            categoryIcons = ["General", "Eating Out", "Housing", "Fuel", "Transportation", "Entertainment", "Groceries", "Clothing","Education", "Hobbies", "Medical"]
        }
    }
}

//MARK: Table view delegate and data source
extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.backgroundColor = UIColor.clear
        cell.icon.image = UIImage(named: categoryIcons[indexPath.row])
        cell.categoryName.text = categoryNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryType = getCategoryType(categoryName: categoryNames[indexPath.row])
        delegate?.categorySelected(categoryName: categoryNames[indexPath.row], categoryType: categoryType)
    }
    
    private func getCategoryType(categoryName: String) -> CategoryType {
        var categoryType: CategoryType
        switch categoryName {
            case "Salary": categoryType = .salary
            case "Investment": categoryType = .investment
            case "Sale": categoryType = .sale
            case "General": categoryType = .general
            case "Eating Out": categoryType = .eatingOut
            case "Housing": categoryType = .housing
            case "Fuel": categoryType = .fuel
            case "Transportation": categoryType = .transportation
            case "Entertainment": categoryType = .entertainment
            case "Groceries": categoryType = .groceries
            case "Clothing": categoryType = .clothing
            case "Education": categoryType = .education
            case "Hobbies": categoryType = .hobbies
            case "Medical": categoryType = .medical
            default: categoryType = .general
        }
        return categoryType
    }
}
