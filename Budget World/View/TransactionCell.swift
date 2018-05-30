//
//  TransactionCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TransactionCell: BaseTableViewCell {
    override func setupViews() {
        super.setupViews()
        addSubview(icon)
        addSubview(categoryName)
        addSubview(date)
        addSubview(transactionAmount)
        setupConstraints()
    }
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 15)
        label.text = "Category name"
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 13)
        label.textColor = .gray
        label.text = "Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let transactionAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textAlignment = .right
        label.text = "$100000.00"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension TransactionCell {
    fileprivate func setupConstraints() {
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        categoryName.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        categoryName.trailingAnchor.constraint(equalTo: transactionAmount.leadingAnchor, constant: -16).isActive = true
        categoryName.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        categoryName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        date.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        date.trailingAnchor.constraint(equalTo: transactionAmount.leadingAnchor, constant: -16).isActive = true
        date.topAnchor.constraint(equalTo: categoryName.bottomAnchor).isActive = true
        date.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        transactionAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        transactionAmount.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
