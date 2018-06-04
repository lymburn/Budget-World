//
//  AddTransactionController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import CoreData

class AddTransactionController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(primary: UIColor.rgb(red: 52, green: 232, blue: 158), secondary: UIColor.rgb(red: 15, green: 52, blue: 67))
        setupBarItems()
        setupViews()
        transactionView.delegate = self
        recurringPicker.delegate = self
        recurringPicker.dataSource = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var transactionType: TransactionType? = nil
    let recurringPeriods = ["Never", "Weekly", "Bi-weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annually", "Annually"]
    var transactionAmount: NSDecimalNumber = 0
    var categoryType: CategoryType!
    
    let recurringPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .clear
        picker.datePickerMode = .date
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        return picker
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        return df
    }()
    
    let transactionView: AddTransactionView = {
        let view = AddTransactionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension AddTransactionController {
    fileprivate func setupViews() {
        navigationItem.title = transactionType! == .income ? "Income" : "Expense"
        view.addSubview(transactionView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        transactionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        transactionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        transactionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        transactionView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
    }
    
    fileprivate func setupBarItems() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        cancelItem.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = cancelItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        doneItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = doneItem
    }
}

//MARK: Events
extension AddTransactionController {
    @objc func cancelButtonPressed() {
        let mainController = SlideMenuController(mainViewController: MainController(), leftMenuViewController: SlideOptionsController())
        mainController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(mainController, animated: true, completion: nil)
    }
    
    @objc func doneButtonPressed() {
        storeTransaction()
        let mainController = SlideMenuController(mainViewController: MainController(), leftMenuViewController: SlideOptionsController())
        mainController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(mainController, animated: true, completion: nil)
    }
    
    @objc func dateValueChanged() {
        transactionView.dateTextField.text = dateFormatter.string(from: datePicker.date)
    }

}

//MARK: Transaction view delegate
extension AddTransactionController: AddTransactionViewDelegate {
    
    func categoryFieldPressed() {
        guard let transactionType = transactionType else {return}
        let categoryController = CategoryController()
        categoryController.transactionType = transactionType
        categoryController.delegate = self
        self.navigationController?.pushViewController(categoryController, animated: true)
    }
    
    func dateFieldPressed() {
        transactionView.dateTextField.inputView = UIView()
        transactionView.dateTextField.inputAccessoryView = datePicker
        transactionView.dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func repeatingFieldPressed() {
        if transactionView.recurringTextField.text == "" {
            //If text is empty, display default never on textfield
            transactionView.recurringTextField.text = "Never"
        }
        transactionView.recurringTextField.inputView = UIView()
        transactionView.recurringTextField.inputAccessoryView = recurringPicker
    }
    
    func amountFieldPressed(amount: NSDecimalNumber) {
        transactionAmount = amount
    }
}

//MARK: Category controller delegate
extension AddTransactionController: CategoryDelegate {
    func categorySelected(categoryName : String, categoryType: CategoryType) {
        self.navigationController?.popViewController(animated: true)
        transactionView.categoryTextField.text = categoryName
        self.categoryType = categoryType
    }
}

//MARK: Recurring picker delegate and data source
extension AddTransactionController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = recurringPeriods[row]
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        transactionView.recurringTextField.text = recurringPeriods[row]
        let recurringPeriod: RecurringPeriod = getRecurringPeriod()
        if recurringPeriod != .never {
            let amountPerDay:NSDecimalNumber = getRecurringTransactionAmount(period: recurringPeriod, date: datePicker.date)
            transactionView.amountPerDayLabel.text = "$" + String(format: "%.2f", Double(truncating: amountPerDay)) + "/day"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurringPeriods.count
    }
    
}

//MARK: Core data storing functions
extension AddTransactionController {
    fileprivate func storeTransaction() {
        let context = AppDelegate.viewContext
        let transaction = Transaction(context: context)
        transaction.amount = transactionAmount
        transaction.amountPerDay = getRecurringTransactionAmount(period: getRecurringPeriod(), date: datePicker.date)
        transaction.date = datePicker.date
        transaction.category = self.categoryType!.rawValue
        transaction.recurringPeriod = getRecurringPeriod().rawValue
        transaction.incomeType = transactionType == .income ? true : false
        
        //Save the context
        do {
            try transaction.managedObjectContext?.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    //Get the repeat period based on the text field input
    private func getRecurringPeriod() -> RecurringPeriod {
        var recurringPeriod: RecurringPeriod
        let periodText = transactionView.recurringTextField.text
        
        switch periodText {
            case "Never": recurringPeriod = .never
            case "Weekly": recurringPeriod = .weekly
            case "Bi-weekly": recurringPeriod = .biWeekly
            case "Monthly": recurringPeriod = .monthly
            case "Bi-monthly": recurringPeriod = .biMonthly
            case "Quarterly": recurringPeriod = .quarterly
            case "Semi-annually": recurringPeriod = .semiAnnually
            case "Annually": recurringPeriod = .annually
            default: recurringPeriod = .never
        }
        return recurringPeriod
    }
    
    //Get the transaction amount per day depending on the recurring period
    fileprivate func getRecurringTransactionAmount(period: RecurringPeriod, date: Date) -> NSDecimalNumber {
        var amountPerDay: NSDecimalNumber = 0
        let numberOfDaysInWeek = NSDecimalNumber(value: 7)
        // Calculate start and end of the month
        let interval = Calendar.current.dateInterval(of: .month, for: date)!
        let numberOfDaysInMonth = NSDecimalNumber(value: Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!)

        switch period {
            case .never: amountPerDay = transactionAmount
            case .weekly: amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/numberOfDaysInWeek.decimalValue)
            case .biWeekly: amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/(numberOfDaysInWeek.decimalValue*2))
            case .monthly: amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/numberOfDaysInMonth.decimalValue)
            case .biMonthly:
                let biMonthlyDays = calculateNumberOfDaysForRecurringPeriod(startingDate: date, numberOfMonths: 2)
                amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/biMonthlyDays.decimalValue)
            case .quarterly:
                let quarterlyDays = calculateNumberOfDaysForRecurringPeriod(startingDate: date, numberOfMonths: 4)
                amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/quarterlyDays.decimalValue)
            case .semiAnnually:
                let semiAnnuallyDays = calculateNumberOfDaysForRecurringPeriod(startingDate: date, numberOfMonths: 6)
                amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/semiAnnuallyDays.decimalValue)
            case .annually:
                let annuallyDays = calculateNumberOfDaysForRecurringPeriod(startingDate: date, numberOfMonths: 12)
                amountPerDay = NSDecimalNumber(decimal: transactionAmount.decimalValue/annuallyDays.decimalValue)
        }
        
        return amountPerDay
    }
    
    private func calculateNumberOfDaysForRecurringPeriod(startingDate: Date, numberOfMonths: Int) -> NSDecimalNumber {
        //Calculate the number of days in the following months from the start date
        var numberOfDays: NSDecimalNumber = 0
        for i in 0...numberOfMonths - 1 {
            var nextMonthComponents = DateComponents()
            nextMonthComponents.month = i
            let nextMonth = Calendar.current.date(byAdding: nextMonthComponents, to: startingDate)!
            let interval = Calendar.current.dateInterval(of: .month, for: nextMonth)!
            let numberOfDaysInNextMonth = NSDecimalNumber(value: Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!)
            numberOfDays = NSDecimalNumber(decimal: numberOfDays.decimalValue + numberOfDaysInNextMonth.decimalValue)
        }
        return numberOfDays
    }
}
