//
//  ViewController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

class MainController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(primary: UIColor.rgb(red: 52, green: 232, blue: 158), secondary: UIColor.rgb(red: 15, green: 52, blue: 67))
        mainView.delegate = self
        setupViews()
        setDefaultMonth()
        updateBalance()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let cellId = "cellId"
    let menuOptions = ["Budget Overview", "Analytics", "Transvarions", "Goals", "Premium", "More"]
    let menuIcons = ["Budget", "Analytics", "Transaction", "Goals", "Premium", "More"]
    var incomeTransactions: [Transaction]!
    var expenseTransactions: [Transaction]!
    var balance: NSDecimalNumber = 0
    var currentMonth: Date!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM"
        return df
    }()
    
    let mainView: MainScreenView = {
        let view = MainScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension MainController {
    fileprivate func setupViews() {
        view.backgroundColor = UIColor.clear
        view.addSubview(mainView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        mainView.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
}

//MARK: Touch events delegate
extension MainController: MainScreenDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func addIncomePressed() {
        let addTransactionController = AddTransactionController()
        addTransactionController.transactionType = .income
        let nav = UINavigationController(rootViewController: addTransactionController)
        nav.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(nav, animated: true, completion: nil)
    }
    
    func addExpensePressed() {
        let addTransactionController = AddTransactionController()
        addTransactionController.transactionType = .expense
        let nav = UINavigationController(rootViewController: addTransactionController)
        nav.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(nav, animated: true, completion: nil)
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
            mainView.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            mainView.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        updateBalance()
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
            mainView.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            mainView.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        updateBalance()
    }
}

//MARK: Calculate and update the UI for the user's balance
extension MainController {
    fileprivate func calculateBalance(_ transactions: [Transaction]) {
        for transaction in transactions {
            if transaction.incomeType {
                //If transaction is an income, add to balance
                balance = NSDecimalNumber(decimal: balance.decimalValue + (transaction.amount?.decimalValue)!)
            } else {
                //If expense, subtract from balance
                balance = NSDecimalNumber(decimal: balance.decimalValue - (transaction.amount?.decimalValue)!)
            }
        }
    }
    
    //Animate the balance changing from 0 to the current balance
    fileprivate func animateBalanceChange() {
        var current: NSDecimalNumber = 0
        let increment = self.balance.decimalValue/50
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {(timer) in
            count += 1
            if count > 50 {
                timer.invalidate()
                //Format based on whether balance is positive or negative
                if self.balance.decimalValue >= 0 {
                    self.mainView.balanceLabel.text = "$" + String(format: "%.2f", Double(truncating: self.balance))
                } else {
                    self.mainView.balanceLabel.text = "-$" + String(format: "%.2f", -Double(truncating: self.balance))
                }
                return
            } else if self.balance.decimalValue < 0 {
                current = NSDecimalNumber(decimal: current.decimalValue - increment)
            } else if self.balance.decimalValue >= 0 {
                current = NSDecimalNumber(decimal: current.decimalValue + increment)
            }
            
            if self.balance.decimalValue >= 0 {
                self.mainView.balanceLabel.text = "$" + String(format: "%.2f", Double(truncating: current))
            } else {
                self.mainView.balanceLabel.text = "-$" + String(format: "%.2f", Double(truncating: current))
            }
        }
    }
 
    fileprivate func updateBalance() {
        //Fetch and update the balance for the current month
        incomeTransactions = TransactionManager.fetchTransactions(incomeType: true, currentMonth: currentMonth)
        expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        balance = 0 //Reset balance first
        calculateBalance(incomeTransactions)
        calculateBalance(expenseTransactions)
        animateBalanceChange()
        createRecurringTransactions()
    }
    
    fileprivate func createRecurringTransactions() {
        //Check to see if there are recurring transactions that need to be created
        let recurringTransactions = TransactionManager.fetchRecurringTransactions()
        for transaction in recurringTransactions {
            //For each recurring transaction, calculate the number of periods since the creation date
            //let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            //let startingDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: transaction.date!)
            let daysDifference = abs(Calendar.current.dateComponents([.day], from: transaction.date!, to: Date()).day!)
            
        }
    }
}

