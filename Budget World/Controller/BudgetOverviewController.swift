//
//  BudgetOverviewController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BudgetOverviewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSymbol = UserDefaults.standard.string(forKey: "currency")
        if currentSymbol == nil {
            currentSymbol = "$"
        }
        
        setupViews()
        budgetView.dateBar.delegate = self
    }
    var currentSymbol:String!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var currentMonth: Date!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "LLLL"
        return df
    }()
    
    let budgetView: BudgetView = {
        let bv = BudgetView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
}

//MARK: Setup
extension BudgetOverviewController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(budgetView)
        setupConstraints()
        setDefaultMonth()
        setBalanceAmounts()
    }
    
    fileprivate func setupConstraints() {
        budgetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        budgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        budgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        budgetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        budgetView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
    
    fileprivate func setBalanceAmounts() {
        //Income
        let incomeTransactions = TransactionManager.fetchTransactions(incomeType: true, currentMonth: currentMonth)
        let totalIncome = calculateTotalTransactions(for: incomeTransactions)
        let salary = calculateTransactions(incomeTransactions, for: .salary)
        let investment = calculateTransactions(incomeTransactions, for: .investment)
        let sale = calculateTransactions(incomeTransactions, for: .sale)
        budgetView.incomeView.incomeAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: totalIncome))
        budgetView.incomeView.salaryAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: salary))
        budgetView.incomeView.investmentAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: investment))
        budgetView.incomeView.saleAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: sale))
        
        //Expenses
        let expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        let totalExpense = calculateTotalTransactions(for: expenseTransactions)
        let general = calculateTransactions(expenseTransactions, for: .general)
        let eating = calculateTransactions(expenseTransactions, for: .eatingOut)
        let housing = calculateTransactions(expenseTransactions, for: .housing)
        let fuel = calculateTransactions(expenseTransactions, for: .fuel)
        let transportation = calculateTransactions(expenseTransactions, for: .transportation)
        let entertainment = calculateTransactions(expenseTransactions, for: .entertainment)
        let groceries = calculateTransactions(expenseTransactions, for: .groceries)
        let clothing = calculateTransactions(expenseTransactions, for: .clothing)
        let education = calculateTransactions(expenseTransactions, for: .education)
        let holiday = calculateTransactions(expenseTransactions, for: .holiday)
        let medical = calculateTransactions(expenseTransactions, for: .medical)
        budgetView.expenseView.expenseAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: totalExpense))
        budgetView.expenseView.generalAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: general))
        budgetView.expenseView.eatingAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: eating))
        budgetView.expenseView.housingAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: housing))
        budgetView.expenseView.fuelAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: fuel))
        budgetView.expenseView.transportationAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: transportation))
        budgetView.expenseView.entertainmentAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: entertainment))
        budgetView.expenseView.groceriesAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: groceries))
        budgetView.expenseView.clothingAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: clothing))
        budgetView.expenseView.educationAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: education))
        budgetView.expenseView.holidayAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: holiday))
        budgetView.expenseView.medicalAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: medical))
        
        //Total balance
        let totalBalance = NSDecimalNumber(decimal: totalIncome.decimalValue - totalExpense.decimalValue)
        if totalBalance.decimalValue >= 0 {
            budgetView.balanceView.balanceAmount.text = currentSymbol + String(format: "%.2f", Double(truncating: totalBalance))
        } else {
            budgetView.balanceView.balanceAmount.text = "-" + currentSymbol + String(format: "%.2f", -Double(truncating: totalBalance))
        }
    }
    
    fileprivate func calculateTotalTransactions(for transactions: [Transaction]) -> NSDecimalNumber {
        //Sum up the total from an array of transactions
        var sum: NSDecimalNumber = 0
        for transaction in transactions {
            sum = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! + sum.decimalValue)
        }
        return sum
    }
    
    fileprivate func calculateTransactions(_ transactions: [Transaction], for category: CategoryType) -> NSDecimalNumber {
        //Calculate the total amount for a specific category
        var sum: NSDecimalNumber = 0
        for transaction in transactions {
            if transaction.category == category.rawValue {
                sum = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! + sum.decimalValue)
            }
        }
        return sum
    }
}

//MARK: Datebar delegate methods
extension BudgetOverviewController: DateBarDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
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
            budgetView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            budgetView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        setBalanceAmounts()
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
            budgetView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            budgetView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        setBalanceAmounts()
    }
}

