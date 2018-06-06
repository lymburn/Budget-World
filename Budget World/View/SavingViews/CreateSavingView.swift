//
//  CreateSavingView.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-01.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol CreateSavingViewDelegate: class {
    func amountPressed(amount: NSDecimalNumber)
}

class CreateSavingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: CreateSavingViewDelegate? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        amountTextField.setBottomBorder(color: UIColor.rgb(red: 51, green: 51, blue: 51))
        descriptionTextField.setBottomBorder(color: UIColor.rgb(red: 51, green: 51, blue: 51))
    }
    
    let amountTextField: TransactionTextField = {
        var currentSymbol = UserDefaults.standard.string(forKey: "currency")
        if currentSymbol == nil {
            currentSymbol = "$"
        }
        let textField = TransactionTextField()
        textField.text = currentSymbol! + "0.00"
        textField.placeholder = "Amount"
        textField.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        textField.addTarget(self, action: #selector(amountTextFieldChanged), for: .editingChanged)
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    
    let descriptionTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.placeholder = "I am saving up for..."
        textField.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        return textField
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension CreateSavingView {
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(amountTextField)
        addSubview(descriptionTextField)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        amountTextField.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 32).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

//MARK: Touch events
extension CreateSavingView {
    @objc func amountTextFieldChanged() {
        if let amount = amountTextField.text?.currencyInputFormatting() {
            let amountString = amount.0
            let amountNumber = amount.1
            amountTextField.text = amountString
            delegate?.amountPressed(amount: amountNumber)
        }
    }
}

