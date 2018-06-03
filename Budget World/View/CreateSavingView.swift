//
//  CreateSavingView.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-01.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class CreateSavingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        amountTextField.setBottomBorder(color: UIColor.rgb(red: 51, green: 51, blue: 51))
        categoryTextField.setBottomBorder(color: UIColor.rgb(red: 51, green: 51, blue: 51))
    }
    
    let amountTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.text = "$0.00"
        textField.placeholder = "Amount"
        textField.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        textField.addTarget(self, action: #selector(amountTextFieldChanged), for: .editingChanged)
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    
    let categoryTextField: TransactionTextField = {
        let textField = TransactionTextField()
        textField.placeholder = "Category"
        textField.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        textField.addTarget(self, action: #selector(categoryTextFieldPressed), for: .touchDown)
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
        addSubview(categoryTextField)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        amountTextField.topAnchor.constraint(equalTo: topAnchor, constant: 48).isActive = true
        amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        categoryTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 32).isActive = true
        categoryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        categoryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

//MARK: Touch events
extension CreateSavingView {
    @objc func amountTextFieldChanged() {
        
    }
    
    @objc func categoryTextFieldPressed() {
        
    }
}

