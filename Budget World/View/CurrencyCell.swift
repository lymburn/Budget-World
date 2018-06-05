//
//  CurrencyCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class CurrencyCell: BaseTableViewCell {
    override func setupViews() {
        super.setupViews()
        addSubview(currencyLabel)
        setupConstraints()
    }
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        return label
    }()
}

extension CurrencyCell {
    fileprivate func setupConstraints() {
        currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        currencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        currencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
