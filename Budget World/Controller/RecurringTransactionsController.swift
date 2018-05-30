//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class RecurringTransactionsController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recurring Transactions"
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        tableView.register(TransactionCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 66
        
        transactions = TransactionManager.fetchRecurringTransactions()
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, YYYY"
        return df
    }()
    
    let recurringPeriods = ["Weekly", "Bi-weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annually", "Annually"]
    let cellId = "cellId"
    var transactions: [Transaction]!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recurringPeriods.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Get number of transactions that have a matching recurring period to the section
        var numberOfRows: Int = 0
        for transaction in transactions {
            //Subtract 1 due to missing "never" period
            if (transaction.recurringPeriod - 1) == section {
                numberOfRows += 1
            }
        }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionCell
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recurringPeriods[section]
    }
}
