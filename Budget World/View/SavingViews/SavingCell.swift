//
//  SavingCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SavingCell: BaseTableViewCell {
    override func setupViews() {
        super.setupViews()
        addSubview(savingDescription)
        addSubview(amountLabel)
        addSubview(progressView)
        setupConstraints()
    }
    
    let savingDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.textColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.textColor = UIColor.rgb(red: 43, green: 132, blue: 210)
        label.textAlignment = .right
        return label
    }()
    
    let progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.progressTintColor = UIColor.rgb(red: 43, green: 132, blue: 210)
        return pv
    }()
}

//MARK: Constraints
extension SavingCell {
    fileprivate func setupConstraints() {
        savingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        savingDescription.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        savingDescription.heightAnchor.constraint(equalToConstant: 27).isActive = true
        savingDescription.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -8).isActive = true
        
        amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: savingDescription.trailingAnchor, constant: 8)
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        progressView.topAnchor.constraint(equalTo: savingDescription.bottomAnchor, constant: 12).isActive = true
        progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
