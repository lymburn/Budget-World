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
    var transactions: [Transaction]!
    
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
        button.addTarget(self, action: #selector(recurringTransactionsPressed), for: .touchDown)
        return button
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 66
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
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
        getTransactions()
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
    
    fileprivate func getTransactions() {
        //Get transactions info from core data for the month
        transactions = TransactionManager.fetchTransactionsByDate(currentMonth: currentMonth)
    }
}

//MARK: Date bar delegate methods
extension TransactionsController: DateBarDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
        let currentYear = Calendar.current.dateComponents([.year], from: Date())
        var previousMonthComponents = DateComponents()
        previousMonthComponents.month = -1
        currentMonth = Calendar.current.date(byAdding: previousMonthComponents, to: currentMonth)
        let currentMonthComponents = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        //Check if year has changed
        if currentYear.year! == currentMonthComponents.year! {
            dateFormatter.dateFormat = "MMM"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        //Get transactions from previous month
        getTransactions()
        tableView.reloadData()
    }
    
    func nextMonthPressed() {
        let currentYear = Calendar.current.dateComponents([.year], from: Date())
        var nextMonthComponents = DateComponents()
        nextMonthComponents.month = 1
        currentMonth = Calendar.current.date(byAdding: nextMonthComponents, to: currentMonth)
        let currentMonthComponents = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        //Check if year has changed
        if currentYear.year! == currentMonthComponents.year! {
            dateFormatter.dateFormat = "MMM"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        //Get transactions from next month
        getTransactions()
        tableView.reloadData()
    }
}

//MARK: Table view delegate and data source
extension TransactionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionCell
        cell.selectionStyle = .none
        dateFormatter.dateFormat = "MMM dd, YYYY"
        //Set cell info
        let transaction = transactions[indexPath.row]
        cell.date.text = dateFormatter.string(from: transaction.date!)
        let cellInfo = TransactionManager.getCategoryNameAndImage(for: transaction)
        let categoryName = cellInfo.0
        let iconName = cellInfo.1
        cell.categoryName.text = categoryName
        cell.icon.image = UIImage(named: iconName)
        
        //Set transaction amount text to green if income and red if expense
        if transaction.incomeType {
            cell.transactionAmount.textColor = UIColor.rgb(red: 44, green: 197, blue: 94)
        } else {
            cell.transactionAmount.textColor = .red
        }
        cell.transactionAmount.text = "$" + String(format: "%.2f", Double(truncating: transaction.amount!))

        return cell
    }
}

//Touch events
extension TransactionsController {
    @objc func recurringTransactionsPressed() {
        let recurringController = RecurringTransactionsController()
        let nav = UINavigationController(rootViewController: recurringController)
        present(nav, animated: true, completion: nil)
    }
}
