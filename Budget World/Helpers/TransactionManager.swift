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
    static func fetchTransactions(incomeType: Bool, currentMonth: Date) -> [Transaction] {
        let transactions: [Transaction]
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        //Fetch for transactions in the current month only
        var components = DateComponents()
        components.month = 1
        let endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "date >= %@ && date < %@ && incomeType == %@", currentMonth as NSDate, endOfMonth as NSDate, NSNumber(booleanLiteral: incomeType))
        
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return transactions
    }
    
    //Fetch transactions in order of descending date
    static func fetchTransactionsByDate(currentMonth: Date) -> [Transaction] {
        let transactions: [Transaction]
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        //Fetch for transactions in the current month only
        var components = DateComponents()
        components.month = 1
        let endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false, selector: nil)]
        request.predicate = NSPredicate(format: "date >= %@ && date < %@", currentMonth as NSDate, endOfMonth as NSDate)
        
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
        request.predicate = NSPredicate(format: "recurringPeriod != %@", Int32(0))
        let context = AppDelegate.viewContext
        do {
            try transactions = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        print(transactions.count)
        
        return transactions
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
            case 4:categoryName = "Eating out"
                    imageName = "Eating OutG"
            case 5:categoryName = "Housing"
                    imageName = "HousingG"
            case 6:categoryName = "Fuel"
                    imageName = "FuelG"
            case 7:categoryName = "Transportation"
                    imageName = "TransportationG"
            case 8:categoryName = "Entertainment"
                    imageName = "EntertainmentG"
            case 9:categoryName = "Groceries"
                    imageName = "GroceriesG"
            case 10:categoryName = "Clothing"
                    imageName = "ClothingG"
            case 11:categoryName = "Education"
                    imageName = "EducationG"
            case 12:categoryName = "Hobbies"
                    imageName = "HobbiesG"
            case 13:categoryName = "Medical"
                    imageName = "MedicalG"
            default: break
        }
        
        return (categoryName, imageName)
    }
}
