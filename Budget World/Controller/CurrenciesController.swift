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
        populateCurrencySymbols()
        
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
    var currencyCodes = ["USD", "CAD", "EUR", "CNY", "GBP", "JPY", "RUB", "KRW", "BRL", "BDT", "NGN", "VND", "PHP",
                        "EGP", "IRR", "MMK", "ZAR", "UAH", "PLN", "NPR"]
    var currencySymbols = [String]()
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
        guard let identifier = Locale.availableIdentifiers.first(where: { Locale(identifier: $0).currencyCode == code }) else { return nil }
        return Locale(identifier: identifier).currencySymbol
    }
    
    fileprivate func populateCurrencySymbols() {
        DispatchQueue.global(qos: .userInitiated).async {
            for code in self.currencyCodes {
                let symbol = self.getSymbolForCurrencyCode(code: code) ?? code
                self.currencySymbols.append(symbol)
                if self.currencySymbols.count == self.currencyCodes.count {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

//MARK: Table view delegate and data source
extension CurrenciesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return 0 if currency symbols is not fully populated
        return currencySymbols.count == currencyCodes.count ? currencySymbols.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CurrencyCell
        cell.selectionStyle = .default
        cell.currencyLabel.text = currencySymbols[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Convert currencies
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.convertCurrencies(to: (self?.currencyCodes[indexPath.row])!)
        }
        //Save currency symbol to user defaults
        UserDefaults.standard.set(currencyCodes[indexPath.row], forKey: "currencyString")
        UserDefaults.standard.set(getSymbolForCurrencyCode(code: currencyCodes[indexPath.row]), forKey: "currency")
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
        //If switching to same currency, return
        if currentCurrency == newCurrency {return}
        
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
