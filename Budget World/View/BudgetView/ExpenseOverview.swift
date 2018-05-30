//
//  ExpenseOverview.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//
import UIKit

class ExpenseOverview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        //Draw separator line under expense
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x:30, y: 23))
        aPath.addLine(to: CGPoint(x: frame.width - 30, y: 23))
        aPath.close()
        UIColor.gray.set()
        aPath.stroke()
    }
    
    let expenseLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Expense"
        label.textColor = UIColor.red
        return label
    }()
    
    let generalLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "General"
        return label
    }()
    
    let eatingLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Eating out"
        return label
    }()
    
    let housingLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Housing"
        return label
    }()
    
    let fuelLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Fuel"
        return label
    }()
    
    let transportationLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Transportation"
        return label
    }()
    
    let entertainmentLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Entertainment"
        return label
    }()
    
    let groceriesLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Groceries"
        return label
    }()
    
    let clothingLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Clothing"
        return label
    }()
    
    let educationLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Education"
        return label
    }()
    
    let hobbiesLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Hobbies"
        return label
    }()
    
    let medicalLabel: BudgetLabel = {
        let label = BudgetLabel()
        label.text = "Medical"
        return label
    }()
    
    let expenseAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textColor = UIColor.red
        label.textAlignment = .right
        return label
    }()
    
    let generalAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let eatingAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let housingAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let fuelAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let transportationAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let entertainmentAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let groceriesAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let clothingAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let educationAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let hobbiesAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    let medicalAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension ExpenseOverview {
    fileprivate func setupViews() {
        addSubview(expenseLabel)
        addSubview(expenseAmount)
        addSubview(generalLabel)
        addSubview(eatingLabel)
        addSubview(housingLabel)
        addSubview(fuelLabel)
        addSubview(transportationLabel)
        addSubview(entertainmentLabel)
        addSubview(groceriesLabel)
        addSubview(clothingLabel)
        addSubview(educationLabel)
        addSubview(hobbiesLabel)
        addSubview(medicalLabel)
        addSubview(generalAmount)
        addSubview(eatingAmount)
        addSubview(housingAmount)
        addSubview(fuelAmount)
        addSubview(transportationAmount)
        addSubview(entertainmentAmount)
        addSubview(groceriesAmount)
        addSubview(clothingAmount)
        addSubview(educationAmount)
        addSubview(hobbiesAmount)
        addSubview(medicalAmount)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        setupLabelConstraints()
        setupAmountConstraints()
    }
    
    fileprivate func setupLabelConstraints() {
        expenseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        expenseLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        generalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        generalLabel.topAnchor.constraint(equalTo: expenseLabel.bottomAnchor, constant: 6).isActive = true
        
        eatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        eatingLabel.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 6).isActive = true
        
        housingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        housingLabel.topAnchor.constraint(equalTo: eatingLabel.bottomAnchor, constant: 6).isActive = true
        
        fuelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        fuelLabel.topAnchor.constraint(equalTo: housingLabel.bottomAnchor, constant: 6).isActive = true
        
        transportationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        transportationLabel.topAnchor.constraint(equalTo: fuelLabel.bottomAnchor, constant: 6).isActive = true
        
        entertainmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        entertainmentLabel.topAnchor.constraint(equalTo: transportationLabel.bottomAnchor, constant: 6).isActive = true
        
        groceriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        groceriesLabel.topAnchor.constraint(equalTo: entertainmentLabel.bottomAnchor, constant: 6).isActive = true
        
        clothingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        clothingLabel.topAnchor.constraint(equalTo: groceriesLabel.bottomAnchor, constant: 6).isActive = true
        
        educationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        educationLabel.topAnchor.constraint(equalTo: clothingLabel.bottomAnchor, constant: 6).isActive = true
        
        hobbiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        hobbiesLabel.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 6).isActive = true
        
        medicalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        medicalLabel.topAnchor.constraint(equalTo: hobbiesLabel.bottomAnchor, constant: 6).isActive = true
    }
    
    fileprivate func setupAmountConstraints() {
        expenseAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        expenseAmount.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        generalAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        generalAmount.topAnchor.constraint(equalTo: expenseAmount.bottomAnchor, constant: 6).isActive = true
        
        eatingAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        eatingAmount.topAnchor.constraint(equalTo: generalAmount.bottomAnchor, constant: 6).isActive = true
        
        housingAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        housingAmount.topAnchor.constraint(equalTo: eatingAmount.bottomAnchor, constant: 6).isActive = true
        
        fuelAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        fuelAmount.topAnchor.constraint(equalTo: housingAmount.bottomAnchor, constant: 6).isActive = true
        
        transportationAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        transportationAmount.topAnchor.constraint(equalTo: fuelAmount.bottomAnchor, constant: 6).isActive = true
        
        entertainmentAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        entertainmentAmount.topAnchor.constraint(equalTo: transportationAmount.bottomAnchor, constant: 6).isActive = true
        
        groceriesAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        groceriesAmount.topAnchor.constraint(equalTo: entertainmentAmount.bottomAnchor, constant: 6).isActive = true
        
        clothingAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        clothingAmount.topAnchor.constraint(equalTo: groceriesAmount.bottomAnchor, constant: 6).isActive = true
        
        educationAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        educationAmount.topAnchor.constraint(equalTo: clothingAmount.bottomAnchor, constant: 6).isActive = true
        
        hobbiesAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        hobbiesAmount.topAnchor.constraint(equalTo: educationAmount.bottomAnchor, constant: 6).isActive = true
        
        medicalAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        medicalAmount.topAnchor.constraint(equalTo: hobbiesAmount.bottomAnchor, constant: 6).isActive = true
    }
}
