//
//  CurrenciesController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class CurrenciesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Currency"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        setupViews()
        setupBarItem()
        
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    let cellId = "cellId"
    var currencies = ["USD", "CAD", "EUR", "GBP", "JPY", "RUB", "KRW", "CNY"]
    var currentSymbol: String!
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets.zero
        tv.rowHeight = 50
        tv.tableFooterView = UIView()
        return tv
    }()

}

//MARK: Setup
extension CurrenciesController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setupBarItem() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        cancelItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancelItem
    }
    
    fileprivate func getSymbolForCurrencyCode(code: String) -> String? {
        let result = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == code }
        return result?.currencySymbol
    }
}

//MARK: Table view delegate and data source
extension CurrenciesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CurrencyCell
        cell.selectionStyle = .default
        let currencySymbol = getSymbolForCurrencyCode(code: currencies[indexPath.row])
        if currencySymbol != nil {
            cell.currencyLabel.text = currencySymbol! + " \(currencies[indexPath.row])"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Convert currencies
        DispatchQueue.global(qos: .userInitiated).async {
            self.convertCurrencies(to: self.currencies[indexPath.row])
        }
        //Save currency symbol to user defaults
        UserDefaults.standard.set(currencies[indexPath.row], forKey: "currencyString")
        UserDefaults.standard.set(getSymbolForCurrencyCode(code: currencies[indexPath.row]), forKey: "currency")
        let savingsController = SlideMenuController(mainViewController: SettingsController(), leftMenuViewController: SlideOptionsController())
        savingsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(savingsController, animated: true, completion: nil)
    }
}

//MARK: Touch events
extension CurrenciesController {
    @objc func cancelButtonPressed() {
        let savingsController = SlideMenuController(mainViewController: SettingsController(), leftMenuViewController: SlideOptionsController())
        savingsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(savingsController, animated: true, completion: nil)
    }
}

//MARK: Currency conversion API functions
extension CurrenciesController {
    //Convert all transactions in database to new currency
    func convertCurrencies(to newCurrency: String) {
        let currentCurrencyString = UserDefaults.standard.string(forKey: "currencyString")
        guard let currentCurrency = currentCurrencyString else {return}
        if currentCurrency == newCurrency {
            //If switching to same currency, return
            return
        }
        
        var currentToEurosRate: NSDecimalNumber!
        var eurosToNewRate: NSDecimalNumber!
        
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=873b83641d14b43af0a3fff0dd3b1d53") else {return}
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    for currency in json["rates"] as! NSDictionary {
                        let currencyString = currency.key as! String
                        if currencyString == currentCurrency {
                            //Get conversion rate from current currency to euros
                            currentToEurosRate = NSDecimalNumber(decimal: (NSNumber(value: 1).decimalValue)/(currency.value as! NSNumber).decimalValue)
                        } else if currencyString == newCurrency {
                            //Get conversion rate from euros to new currency
                            eurosToNewRate = NSDecimalNumber(decimal: (currency.value as! NSNumber).decimalValue)
                        }
                    }
                    DispatchQueue.main.async {
                        self.updateCurrencies(currentToEuros: currentToEurosRate, eurosToNew: eurosToNewRate)
                    }
                }
            } catch {
                print("json error: \(error)")
            }
        }
        task.resume()
    }
    
    //Update all the currencies stored in Core Data
    func updateCurrencies(currentToEuros: NSDecimalNumber, eurosToNew: NSDecimalNumber) {
        let transactions = TransactionManager.fetchAllTransactions()
        for transaction in transactions {
            transaction.amount = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! * currentToEuros.decimalValue)
            transaction.amount = NSDecimalNumber(decimal: (transaction.amount?.decimalValue)! * eurosToNew.decimalValue)
            //Save change
            do {
                try transaction.managedObjectContext?.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
