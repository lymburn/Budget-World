//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class RecurringTransactionsController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recurring Transactions"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        tableView.register(TransactionCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 66
        
        currentSymbol = UserDefaults.standard.string(forKey: "currency")
        if currentSymbol == nil {
            currentSymbol = "$"
        }
        
        setupBackButton()
        getTransactions()
    }
    
    var currentSymbol:String!
    
    fileprivate func getTransactions() {
        //Populate 2d array with arrays of transactions as values and section as keys
        let recurringTransactions = TransactionManager.fetchRecurringTransactions()
        for transaction in recurringTransactions {
            if transaction.recurringDaysCount != -1 {
                //If the recurring transaction hasn't been deleted yet
                transactions[Int(transaction.recurringPeriod - 1)].append(transaction)
            }
        }
    }
    
    fileprivate func setupBackButton() {
        let cancelItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
        cancelItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancelItem
    }

    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, YYYY"
        return df
    }()
    
    let recurringPeriods = ["Weekly", "Bi-weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annually", "Annually"]
    let cellId = "cellId"
    var transactions = [[Transaction]].init(repeating: [Transaction](), count: 7)
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recurringPeriods.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Only show section if the section has rows
        if transactions[section].count == 0 {
            return 0.0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.zero
        let transaction = transactions[indexPath.section][indexPath.row]
        cell.date.text = "Started on " + dateFormatter.string(from: transaction.date!)
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
        cell.transactionAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: transaction.amount!))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recurringPeriods[section]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //Set recurring period to be never
            transactions[indexPath.section][indexPath.row].recurringDaysCount = -1
            //Update recurring period
            do {
                try transactions[indexPath.section][indexPath.row].managedObjectContext?.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            //Update table
            transactions[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

//MARK: Touch events
extension RecurringTransactionsController {
    @objc func backButtonPressed() {
        let transactionController = SlideMenuController(mainViewController: TransactionsController(), leftMenuViewController: SlideOptionsController())
        transactionController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(transactionController, animated: true, completion: nil)
    }
}
