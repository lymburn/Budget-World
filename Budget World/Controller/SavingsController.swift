//
//  SavingsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-01.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData
import PMAlertController

class SavingsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Savings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        
        currentSymbol = UserDefaults.standard.string(forKey: "currency")
        if currentSymbol == nil {
            currentSymbol = "$"
        }
        
        tableView.register(SavingCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        setupViews()
        savings = SavingManager.fetchSavings()
    }
    
    var savings: [Saving]!
    let cellId = "cellId"
    var depositVC: PMAlertController!
    var currentSymbol: String!
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorInset = UIEdgeInsets.zero
        tv.rowHeight = 70
        tv.tableFooterView = UIView()
        return tv
    }()
    
    let slideMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(slideMenuPressed), for: .touchDown)
        return button
    }()
    
    let savingsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.text = "Savings"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        return label
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create New Saving", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 17)
        button.addTarget(self, action: #selector(createSavingPressed), for: .touchDown)
        return button
    }()
}

//MARK: Setup
extension SavingsController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(savingsLabel)
        view.addSubview(createButton)
        view.addSubview(slideMenu)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        savingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        savingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        savingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        savingsLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        slideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        slideMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: savingsLabel.bottomAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: createButton.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

//MARK: Table view data source and delegate
extension SavingsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let saving = savings[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SavingCell
        cell.selectionStyle = .default
        cell.amountLabel.text = currentSymbol + String(format: "%.2f", Double(truncating: saving.amount!))
        cell.savingDescription.text = saving.savingDescription!
        
        //Progress bar amount
        let decimalProgress = NSDecimalNumber(decimal: 1 - (saving.amount?.decimalValue)!/(saving.originalAmount?.decimalValue)!)
        let progress = Float(truncating: decimalProgress)
        cell.progressView.progress = progress
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        depositVC = PMAlertController(title: "Deposit", description: "Deposit how much you want to add towards your savings goal.", image: UIImage(named: "Deposit"), style: .alert)
        depositVC.addTextField { (textField) in
            guard let textField = textField else {return}
            textField.placeholder = "Amount"
            textField.keyboardType = UIKeyboardType.numberPad
        }
        depositVC.textFields[0].addTarget(self, action: #selector(depositTextFieldChanged), for: .editingChanged)
        depositVC.addAction(PMAlertAction(title: "Deposit", style: .default, action: { () in
            //Update savings amount
            if let amount = self.depositVC.textFields[0].text?.currencyInputFormatting() {
                let newAmount = NSDecimalNumber(decimal: (self.savings[indexPath.row].amount?.decimalValue)! - amount.1.decimalValue)
                //Default to 0 if new deposit result in negative
                self.savings[indexPath.row].amount = newAmount.decimalValue >= 0 ? newAmount : NSDecimalNumber(decimal: 0)
                do {
                    try self.savings[indexPath.row].managedObjectContext?.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            }
            //Reload table
            self.tableView.reloadData()
        }))
        depositVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
        }))
        self.present(depositVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let context = AppDelegate.viewContext
            context.delete(savings[indexPath.row])
            savings.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

//MARK: Touch events
extension SavingsController {
    @objc func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    @objc func createSavingPressed() {
        let createController = CreateSavingController()
        let nav = UINavigationController(rootViewController: createController)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func depositTextFieldChanged() {
        if let amount = depositVC.textFields[0].text?.currencyInputFormatting() {
            depositVC.textFields[0].text = amount.0
        }
    }
}
