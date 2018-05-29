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
        incomeTransactions = fetchTransactions(incomeType: true)
        expenseTransactions = fetchTransactions(incomeType: false)
        calculateBalance(incomeTransactions)
        calculateBalance(expenseTransactions)
        storeBalance()
    }
    
    let cellId = "cellId"
    let menuOptions = ["Budget Overview", "Analytics", "Transvarions", "Goals", "Premium", "More"]
    let menuIcons = ["Budget", "Analytics", "Transaction", "Goals", "Premium", "More"]
    var incomeTransactions: [Transaction]!
    var expenseTransactions: [Transaction]!
    var balance: NSDecimalNumber = 0
    
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
}

//MARK: Fetch core data info about user balance for the month
extension MainController {
    fileprivate func fetchTransactions(incomeType: Bool) -> [Transaction] {
        let transactions: [Transaction]
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: components)!
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "date > %@ && incomeType == %@", startOfMonth as NSDate, NSNumber(booleanLiteral: incomeType))

        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        //Set balance to the account balance of the transactions
        return transactions
    }
    
    //Store the new calculated
    fileprivate func storeBalance() {
        let context = AppDelegate.viewContext
        let account = Account(context: context)
        account.balance = balance
        //Save the context
        do {
            try account.managedObjectContext?.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
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
}

