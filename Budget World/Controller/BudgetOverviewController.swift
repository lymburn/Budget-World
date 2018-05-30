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
        budgetView.dateBar.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
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
        budgetView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
    
    
    fileprivate func setBalanceAmounts() {
        //Set income/expense amount
        let incomeTransactions = TransactionManager.fetchTransactions(incomeType: true, currentMonth: currentMonth)
        let expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        let totalIncome = calculateTotalTransactions(for: incomeTransactions)
        let totalExpense = calculateTotalTransactions(for: expenseTransactions)
        let salary = calculateTransactions(incomeTransactions, for: .salary)
        let investment = calculateTransactions(incomeTransactions, for: .investment)
        let sale = calculateTransactions(incomeTransactions, for: .sale)
        budgetView.incomeView.incomeAmount.text = "$" + String(format: "%.2f", Double(truncating: totalIncome))
        budgetView.incomeView.salaryAmount.text = "$" + String(format: "%.2f", Double(truncating: salary))
        budgetView.incomeView.investmentAmount.text = "$" + String(format: "%.2f", Double(truncating: investment))
        budgetView.incomeView.saleAmount.text = "$" + String(format: "%.2f", Double(truncating: sale))
    }
    
    fileprivate func calculateTotalTransactions(for transactions: [Transaction]) -> NSDecimalNumber {
        //Sum up the total from an array of transactions
        var sum: NSDecimalNumber = 0
        for transaction in transactions {
            sum = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! + sum.decimalValue)
        }
        return sum
    }
    
    fileprivate func calculateTransactions(_ transactions: [Transaction], for category: CategoryType) -> NSDecimalNumber {
        //Calculate the total amount for a specific category
        var sum: NSDecimalNumber = 0
        for transaction in transactions {
            if transaction.category == category.rawValue {
                sum = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! + sum.decimalValue)
            }
        }
        return sum
    }
}

//MARK: Budgetview delegate methods
extension BudgetOverviewController: DateBarDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
        
    }
    
    func nextMonthPressed() {
        
    }
}

