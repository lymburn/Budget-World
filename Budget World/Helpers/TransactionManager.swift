//
//  TransactionManager.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import CoreData

//Helper class for transaction info
class TransactionManager {
    
    //Fetch NON-RECURRING transactions
    static func fetchTransactions(incomeType: Bool, currentMonth: Date) -> [Transaction] {
        let transactions: [Transaction]
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        //Fetch for transactions in the current month only
        var components = DateComponents()
        components.month = 1
        let endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "date >= %@ && date < %@ && incomeType == %@ && recurringPeriod == %@", currentMonth as NSDate, endOfMonth as NSDate, NSNumber(booleanLiteral: incomeType), NSNumber(value: 0))
        
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return transactions
    }
    
    //Fetch transactions in order of descending date
    static func fetchTransactionsByMonth(currentMonth: Date) -> [Transaction] {
        let transactions: [Transaction]
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        //Fetch for transactions in the current month only
        var components = DateComponents()
        components.month = 1
        let endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false, selector: nil)]
        request.predicate = NSPredicate(format: "date >= %@ && date < %@ && recurringPeriod == %@", currentMonth as NSDate, endOfMonth as NSDate, NSNumber(value: 0))
        
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return transactions
    }
    
    static func fetchRecurringTransactions() -> [Transaction] {
        //Fetch only recurring transactions
        let transactions: [Transaction]
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "recurringPeriod > %@", NSNumber(value: 0))
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return transactions
    }
    
    static func fetchTransactionsByDay(day: Date) -> [Transaction] {
        let transactions: [Transaction]
        var components = DateComponents()
        components.day = 1
        let nextDay = Calendar.current.date(byAdding: components, to: day)!
        
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        //Fetch for transactions in the current month only
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "date >= %@ && date < %@", day as NSDate, nextDay as NSDate)
        
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return transactions
    }
    
    static func fetchAllTransactions() -> [Transaction] {
        let transactions: [Transaction]
        
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = nil
        
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return transactions
    }
    
    static func calculateBalance(_ transactions: [Transaction]) -> NSDecimalNumber {
        var balance: NSDecimalNumber = 0
        for transaction in transactions {
            if transaction.incomeType {
                //If transaction is an income, add to balance
                balance = NSDecimalNumber(decimal: balance.decimalValue + (transaction.amount?.decimalValue)!)
            } else {
                //If expense, subtract from balance
                balance = NSDecimalNumber(decimal: balance.decimalValue - (transaction.amount?.decimalValue)!)
            }
        }
        return balance
    }
    
    static func getCategoryNameAndImage(for transaction: Transaction) -> (String, String) {
        var categoryName: String = ""
        var imageName: String = ""
        switch transaction.category {
            case 0: categoryName = "Salary"
                    imageName = "SalaryG"
            case 1: categoryName = "Investment"
                    imageName = "InvestmentG"
            case 2: categoryName = "Sale"
                    imageName = "SaleG"
            case 3: categoryName = "General"
                    imageName = "GeneralG"
            case 4:categoryName = "Housing"
                    imageName = "HousingG"
            case 5:categoryName = "Fuel"
                    imageName = "FuelG"
            case 6:categoryName = "Transportation"
                    imageName = "TransportationG"
            case 7:categoryName = "Eating Out"
                    imageName = "Eating OutG"
            case 8:categoryName = "Entertainment"
                    imageName = "EntertainmentG"
            case 9:categoryName = "Holiday"
                    imageName = "HolidayG"
            case 10:categoryName = "Groceries"
                    imageName = "GroceriesG"
            case 11:categoryName = "Clothing"
                    imageName = "ClothingG"
            case 12:categoryName = "Medical"
                    imageName = "MedicalG"
            case 13:categoryName = "Education"
                    imageName = "EducationG"

            default: break
        }
        
        return (categoryName, imageName)
    }
}
