//
//  TransactionsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TransactionsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        dateBar.delegate = self
        
        tableView.register(TransactionCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var currentMonth: Date!
    let cellId = "cellId"
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "LLLL"
        return df
    }()
    
    let dateBar: DateBar = {
        let db = DateBar()
        db.translatesAutoresizingMaskIntoConstraints = false
        return db
    }()
    
    let manageRecurringButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("View Recurring Transactions", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 50
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
}

//MARK: Setup
extension TransactionsController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(dateBar)
        view.addSubview(manageRecurringButton)
        view.addSubview(tableView)
        setupConstraints()
        setDefaultMonth()
    }
    
    fileprivate func setupConstraints() {
        dateBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        manageRecurringButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        manageRecurringButton.topAnchor.constraint(equalTo: dateBar.bottomAnchor).isActive = true
        manageRecurringButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        manageRecurringButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableView.topAnchor.constraint(equalTo: manageRecurringButton.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
}

//MARK: Date bar delegate methods
extension TransactionsController: DateBarDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
        
    }
    
    func nextMonthPressed() {
        
    }
}

//MARK: Table view delegate and data source
extension TransactionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionCell
        cell.icon.image = UIImage(named: "Salary")
        return cell
    }
}
