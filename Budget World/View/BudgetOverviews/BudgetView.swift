//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BudgetView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let dateBar: DateBar = {
        let db = DateBar()
        db.translatesAutoresizingMaskIntoConstraints = false
        return db
    }()
    
    let incomeView: IncomeOverview = {
        let iv = IncomeOverview()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let expenseView: ExpenseOverview = {
        let ev = ExpenseOverview()
        ev.translatesAutoresizingMaskIntoConstraints = false
        return ev
    }()
    
    let balanceView: BalanceOverview = {
        let bv = BalanceOverview()
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension BudgetView {
    fileprivate func setupViews() {
        addSubview(dateBar)
        addSubview(incomeView)
        addSubview(expenseView)
        addSubview(balanceView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        dateBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dateBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dateBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        incomeView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        incomeView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        incomeView.topAnchor.constraint(equalTo: dateBar.bottomAnchor, constant: 24).isActive = true
        incomeView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        expenseView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        expenseView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        expenseView.topAnchor.constraint(equalTo: incomeView.bottomAnchor, constant: 24).isActive = true
        expenseView.heightAnchor.constraint(equalToConstant: 315).isActive = true
        
        balanceView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        balanceView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        balanceView.topAnchor.constraint(equalTo: expenseView.bottomAnchor, constant: 24).isActive = true
        balanceView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}


