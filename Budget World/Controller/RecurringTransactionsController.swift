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
    
    let recurringPeriods = ["Weekly", "Bi-weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annually", "Annually"]
    let cellId = "cellId"
    var transactions: [Transaction]!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recurringPeriods.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Get number of transactions that have a matching recurring period to the section
        //print(section)
        var numberOfRows: Int = 0
        
        for transaction in transactions {
            print(transaction.recurringPeriod - 1)
            //Subtract 1 due to missing "never" period
            if (transaction.recurringPeriod - 1) == section {
                numberOfRows += 1
            }
        }
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recurringPeriods[section]
    }
}
