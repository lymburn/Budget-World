//
//  IncomeOverview.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class IncomeOverview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let incomeLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Income"
        return label
    }()
    
    let salaryLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Salary"
        return label
    }()
    
    let investmentLabel : BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Investment"
        return label
    }()
    
    let saleLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Sale"
        return label
    }()
    
    let salaryAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textColor = UIColor.rgb(red: 44, green: 197, blue: 94)
        label.textAlignment = .right
        return label
    }()
    
    let investmentAmount : BudgetLabel = {
        let label = BudgetLabel()
        label.textColor = UIColor.rgb(red: 44, green: 197, blue: 94)
        label.textAlignment = .right
        return label
    }()
    
    let saleAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textColor = UIColor.rgb(red: 44, green: 197, blue: 94)
        label.textAlignment = .right
        return label
    }()
    
    let incomeAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textColor = UIColor.rgb(red: 44, green: 197, blue: 94)
        label.textAlignment = .right
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension IncomeOverview {
    fileprivate func setupViews() {
        addSubview(incomeLabel)
        addSubview(incomeAmount)
        addSubview(salaryLabel)
        addSubview(investmentLabel)
        addSubview(saleLabel)
        addSubview(salaryAmount)
        addSubview(investmentAmount)
        addSubview(saleAmount)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        incomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        incomeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        salaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        salaryLabel.topAnchor.constraint(equalTo: incomeAmount.bottomAnchor, constant: 6).isActive = true
        
        investmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        investmentLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 6).isActive = true
        
        saleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        saleLabel.topAnchor.constraint(equalTo: investmentLabel.bottomAnchor, constant: 6).isActive = true
        
        incomeAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        incomeAmount.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        salaryAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        salaryAmount.topAnchor.constraint(equalTo: incomeAmount.bottomAnchor, constant: 6).isActive = true
        
        investmentAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        investmentAmount.topAnchor.constraint(equalTo: salaryAmount.bottomAnchor, constant: 6).isActive = true
        
        saleAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        saleAmount.topAnchor.constraint(equalTo: investmentAmount.bottomAnchor, constant: 6).isActive = true
    }
}
