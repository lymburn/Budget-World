//
//  ViewController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(primary: UIColor.rgb(red: 52, green: 232, blue: 158), secondary: UIColor.rgb(red: 15, green: 52, blue: 67))
        mainView.delegate = self
        setupViews()
    }
    
    let cellId = "cellId"
    let menuOptions = ["Budget Overview", "Analytics", "Transvarions", "Goals", "Premium", "More"]
    let menuIcons = ["Budget", "Analytics", "Transaction", "Goals", "Premium", "More"]
    
    let mainView: MainScreenView = {
        let view = MainScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension MainController {
    fileprivate func setupViews() {
        view.backgroundColor = UIColor.clear
        view.addSubview(mainView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
 
    }
}

//MARK: Touch events delegate
extension MainController: MainScreenDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func addIncomePressed() {
        let addTransactionController = AddTransactionController()
        addTransactionController.transaction = .income
        let nav = UINavigationController(rootViewController: addTransactionController)
        nav.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(nav, animated: true, completion: nil)
    }
    
    func addExpensePressed() {
        let addTransactionController = AddTransactionController()
        addTransactionController.transaction = .expense
        let nav = UINavigationController(rootViewController: addTransactionController)
        nav.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(nav, animated: true, completion: nil)
    }
}

