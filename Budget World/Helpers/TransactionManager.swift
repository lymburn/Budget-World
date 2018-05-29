//
//  TransactionManager.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import CoreData

//Helper class to fetch info from core data and calculate balances
class TransactionManager {
    static func fetchTransactions(incomeType: Bool, currentMonth: Date) -> [Transaction] {
        let transactions: [Transaction]
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        //Fetch for transactions in the current month only
        var components = DateComponents()
        components.month = 1
        components.day = -1
        let endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "date >= %@ && date <= %@ && incomeType == %@", currentMonth as NSDate, endOfMonth as NSDate, NSNumber(booleanLiteral: incomeType))
        
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        //Set balance to the account balance of the transactions
        return transactions
    }
}
