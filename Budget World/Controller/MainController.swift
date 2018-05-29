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
        getTransactions()
    }
    
    let cellId = "cellId"
    let menuOptions = ["Budget Overview", "Analytics", "Transvarions", "Goals", "Premium", "More"]
    let menuIcons = ["Budget", "Analytics", "Transaction", "Goals", "Premium", "More"]
    var transactions: [NSManagedObject]!
    
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
    fileprivate func getTransactions() {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: components)!
        print(startOfMonth)
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "date > %@", startOfMonth as NSDate)

        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
            print(transactions.count)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
    }
}

