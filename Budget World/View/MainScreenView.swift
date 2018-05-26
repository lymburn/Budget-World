//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol MainScreenDelegate: class {
    func slideMenuPressed()
    func addIncomePressed()
    func addExpensePressed()
}

class MainScreenView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    
    weak var delegate: MainScreenDelegate?
    
    let balanceLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 70)
        label.text = "$0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 40)
        label.text = "May 25"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addIncomeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("Add Income", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addIncomePressed), for: .touchDown)
        return button
    }()
    
    let addExpenseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Expense", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addExpensePressed), for: .touchDown)
        return button
    }()
    
    let slideMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(slideMenuPressed), for: .touchDown)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Setup
extension MainScreenView {
    fileprivate func setupViews() {
        addSubview(balanceLabel)
        addSubview(dateLabel)
        addSubview(addIncomeButton)
        addSubview(addExpenseButton)
        addSubview(slideMenu)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        balanceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50).isActive = true
        balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addIncomeButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 100).isActive = true
        addIncomeButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addIncomeButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addExpenseButton.topAnchor.constraint(equalTo: addIncomeButton.bottomAnchor, constant: 30).isActive = true
        addExpenseButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addExpenseButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        slideMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        slideMenu.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}

//MARK: Touch Events
extension MainScreenView {
    @objc func addIncomePressed() {
        delegate?.addIncomePressed()
    }
    
    @objc func addExpensePressed() {
        delegate?.addExpensePressed()
    }
    
    @objc func slideMenuPressed() {
        delegate?.slideMenuPressed()
    }
}