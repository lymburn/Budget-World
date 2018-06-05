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
        setupBarItems()
        
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let cellId = "cellId"
    let currencies = ["USD", "EUR", "GBP", "INR", "JPY", "RUB", "KPW","CRC", "CZK", "DKK",  "AFN", "ALL", "DZD","ILS", "AOA", "AMD", "BHD", "BDT", "GEL", "GHS", "GNF", "KZT", "MYR", "QAR", "ZAR"]
    
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
    
    fileprivate func setupBarItems() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        cancelItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancelItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        doneItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = doneItem
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
        let currencySymbol = getSymbolForCurrencyCode(code: currencies[indexPath.row])
        if currencySymbol != nil {
            cell.currencyLabel.text = currencySymbol!
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}

//MARK: Touch events
extension CurrenciesController {
    @objc func cancelButtonPressed() {
        let savingsController = SlideMenuController(mainViewController: SettingsController(), leftMenuViewController: SlideOptionsController())
        savingsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(savingsController, animated: true, completion: nil)
    }
    
    @objc func doneButtonPressed() {
        let savingsController = SlideMenuController(mainViewController: SettingsController(), leftMenuViewController: SlideOptionsController())
        savingsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(savingsController, animated: true, completion: nil)
    }
}

