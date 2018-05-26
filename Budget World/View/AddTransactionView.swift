//
//  AddTransactionView.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class AddTransactionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        amountTextField.setBottomBorder()
        dateTextField.setBottomBorder()
        categoryTextField.setBottomBorder()
        noteTextField.setBottomBorder()
    }
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Amount"
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont(name: "OpenSans-Regular", size: 25)
        return textField
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Date"
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont(name: "OpenSans-Regular", size: 25)
        return textField
    }()
    
    let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Category"
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont(name: "OpenSans-Regular", size: 25)
        return textField
    }()
    
    let noteTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Note"
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont(name: "OpenSans-Regular", size: 25)
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
        
        noteTextField.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 32).isActive = true
        noteTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        noteTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        noteTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
