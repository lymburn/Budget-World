//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class MainScreenView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let balanceLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "$0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let incomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.text = "$0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let expensesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.text = "$0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Setup
extension MainScreenView {
    fileprivate func setupViews() {
        addSubview(balanceLabel)
        addSubview(incomeLabel)
        addSubview(expensesLabel)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        balanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        incomeLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant:32).isActive = true
        incomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        incomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        incomeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        expensesLabel.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 32).isActive = true
        expensesLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        expensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        expensesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
