//
//  BudgetOverviewController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BudgetOverviewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    var currentMonth: Date!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "LLLL"
        return df
    }()
    
    let budgetView: BudgetView = {
        let bv = BudgetView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
}

//MARK: Setup
extension BudgetOverviewController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(budgetView)
        setupConstraints()
        setDefaultMonth()
        setBalanceAmounts()
    }
    
    fileprivate func setupConstraints() {
        budgetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        budgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        budgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        budgetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        budgetView.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
    
    
    fileprivate func setBalanceAmounts() {
        //Set income/expense amount
        let incomeTransactions = TransactionManager.fetchTransactions(incomeType: true, currentMonth: currentMonth)
        let expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        let totalIncome: NSDecimalNumber = calculateTransactions(for: incomeTransactions)
        let totalExpense: NSDecimalNumber = calculateTransactions(for: expenseTransactions)
        budgetView.incomeAmount.text = "$" + String(format: "%.2f", Double(truncating: totalIncome))
    }
    
    fileprivate func calculateTransactions(for transactions: [Transaction]) -> NSDecimalNumber {
        //Sum up the total from an array of transactions
        var sum: NSDecimalNumber = 0
        for transaction in transactions {
            sum = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! + sum.decimalValue)
        }
        return sum
    }
}