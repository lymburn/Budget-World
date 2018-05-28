//
//  AddTransactionView.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol AddTransactionViewDelegate: class {
    func amountFieldPressed(amount: NSDecimalNumber)
    func categoryFieldPressed()
    func dateFieldPressed()
    func repeatingFieldPressed()
}

class AddTransactionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate : AddTransactionViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        amountTextField.setBottomBorder()
        dateTextField.setBottomBorder()
        categoryTextField.setBottomBorder()
        recurringTextField.setBottomBorder()
        noteTextField.setBottomBorder()
    }
    
    let amountTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.text = "$0.00"
        textField.placeholder = "Amount"
        textField.addTarget(self, action: #selector(amountTextFieldChanged), for: .editingChanged)
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    
    let dateTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.placeholder = "Date"
        textField.addTarget(self, action: #selector(dateTextFieldPressed), for: .touchDown)
        return textField
    }()
    
    let categoryTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.placeholder = "Category"
        textField.addTarget(self, action: #selector(categoryTextFieldPressed), for: .touchDown)
        return textField
    }()
    
    let recurringTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.placeholder = "Recurring?"
        textField.addTarget(self, action: #selector(repeatingTextFieldPressed), for: .touchDown)
        return textField
    }()
    
    let noteTextField : TransactionTextField = {
        let textField = TransactionTextField()
        textField.placeholder = "Note"
        return textField
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension AddTransactionView {
    fileprivate func setupViews() {
        addSubview(amountTextField)
        addSubview(dateTextField)
        addSubview(categoryTextField)
        addSubview(recurringTextField)
        addSubview(noteTextField)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        amountTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dateTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 32).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        categoryTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 32).isActive = true
        categoryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        categoryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        recurringTextField.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 32).isActive = true
        recurringTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        recurringTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        recurringTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        noteTextField.topAnchor.constraint(equalTo: recurringTextField.bottomAnchor, constant: 32).isActive = true
        noteTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        noteTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        noteTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

//MARK: Touch events
extension AddTransactionView {
    @objc func amountTextFieldChanged() {
        if let amount = amountTextField.text?.currencyInputFormatting() {
            let amountString = amount.0
            let amountNumber = amount.1
            amountTextField.text = amountString
            delegate?.amountFieldPressed(amount: amountNumber)
        }
    }
    
    @objc func categoryTextFieldPressed() {
        delegate?.categoryFieldPressed()
    }
    
    @objc func dateTextFieldPressed() {
        delegate?.dateFieldPressed()
    }
    
    @objc func repeatingTextFieldPressed() {
        delegate?.repeatingFieldPressed()
    }
}
