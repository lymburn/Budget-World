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
        setupViews()
    }
    
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
    }
    
    fileprivate func setupConstraints() {
        budgetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        budgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        budgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        budgetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
