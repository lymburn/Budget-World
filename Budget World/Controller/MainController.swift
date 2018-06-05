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
        currentSymbol = UserDefaults.standard.string(forKey: "currency")
        if currentSymbol == nil {
            currentSymbol = "$"
        }
        
        setupViews()
        setDefaultMonth()
        updateBalance()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    var currentSymbol: String!
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
                    self.mainView.balanceLabel.text = self.currentSymbol + String(format: "%.2f", Double(truncating: self.balance))
                } else {
                    self.mainView.balanceLabel.text = "-" + self.currentSymbol + String(format: "%.2f", -Double(truncating: self.balance))
                }
                return
            } else if self.balance.decimalValue < 0 {
                current = NSDecimalNumber(decimal: current.decimalValue - increment)
            } else if self.balance.decimalValue >= 0 {
                current = NSDecimalNumber(decimal: current.decimalValue + increment)
            }
            
            if self.balance.decimalValue >= 0 {
                self.mainView.balanceLabel.text = self.currentSymbol + String(format: "%.2f", Double(truncating: current))
            } else {
                self.mainView.balanceLabel.text = "-" + self.currentSymbol + String(format: "%.2f", Double(truncating: current))
            }
        }
    }
 
    fileprivate func updateBalance() {
        //Fetch and update the balance for the current month
        createRecurringTransactions()
        incomeTransactions = TransactionManager.fetchTransactions(incomeType: true, currentMonth: currentMonth)
        expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        balance = 0 //Reset balance first
        balance = TransactionManager.calculateBalance(incomeTransactions)
        print(balance)
        balance = NSDecimalNumber(decimal: balance.decimalValue + TransactionManager.calculateBalance(expenseTransactions).decimalValue)
        print(balance)
        animateBalanceChange()
    }
    
    
    fileprivate func createRecurringTransactions() {
        //Check to see if there are recurring transactions that need to be created
        let recurringTransactions = TransactionManager.fetchRecurringTransactions()
        let context = AppDelegate.viewContext
        let calendar = Calendar.current
        for transaction in recurringTransactions {
            //If recurring days count is negative, the transaction is no longer recurring so return
            guard transaction.recurringDaysCount >= 0 else {return}
            
            //Increment from the starting date to the number of recurring days so far
            var recurringPeriodComponents = DateComponents()
            recurringPeriodComponents.day = Int(transaction.recurringDaysCount)
            //Calculate number of dates since last recurring transactions was last updated
            let incrementedTransactionDate = calendar.date(byAdding: recurringPeriodComponents, to: transaction.date!)!
            let daysDifference = Calendar.current.dateComponents([.day], from: incrementedTransactionDate, to: Date()).day!
            
            //Only add recurring transactions if the days were in the past. Don't show future recurrences until the time comes
            if daysDifference > 0 {
                //Loop through each day and create a new transaction
                //If updating recurring transaction for the first time, start at 0th index. Else, skip the 0th index to prevent adding the same transaction twice
                let startingIndex: Int = transaction.recurringDaysCount > 0 ? 1 : 0
                for i in startingIndex...daysDifference {
                    //Create new transaction with no recurring period and with amount equal to the amount per day
                    let recurringTran = Transaction(context: context)
                    recurringTran.amount = transaction.amountPerDay
                    recurringTran.category = transaction.category
                    recurringTran.incomeType = transaction.incomeType
                    
                    //Date is based on which date it is in between the starting date and current date
                    var transactionDateComponents = DateComponents()
                    transactionDateComponents.day = i

                    let transactionDate = calendar.date(byAdding: transactionDateComponents, to: incrementedTransactionDate)
                    recurringTran.date = transactionDate
                    
                    //Store transaction
                    do {
                        try recurringTran.managedObjectContext?.save()
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
                
                //Update the recurring transactions period count so that its starting date can match the current date
                transaction.recurringDaysCount = transaction.recurringDaysCount + Int32(daysDifference)
                
                //Save context
                do {
                    try transaction.managedObjectContext?.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
            
        }
    }
}

