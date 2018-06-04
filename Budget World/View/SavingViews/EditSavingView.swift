//
//  EditSavingView.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class EditSavingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let savingDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let savingAmount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension EditSavingView {
    fileprivate func setupViews() {
        addSubview(savingDescription)
        addSubview(savingAmount)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        savingDescription.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        savingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        savingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        savingDescription.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        savingAmount.topAnchor.constraint(equalTo: savingDescription.bottomAnchor, constant: 16).isActive = true
        savingAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        savingAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        savingAmount.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
