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
        label.font = UIFont(name: "OpenSans-Regular", size: 60)
        label.text = "$0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Regular", size: 40)
        label.text = "May 25"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addIncomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Income", for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 30)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2/UIScreen.main.nativeScale
        button.contentEdgeInsets = UIEdgeInsetsMake(8, 22, 8, 22)
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addIncomePressed), for: .touchDown)
        return button
    }()
    
    let addExpenseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Expense", for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 30)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2/UIScreen.main.nativeScale
        button.contentEdgeInsets = UIEdgeInsetsMake(8, 16,8, 16)
        button.layer.borderColor = UIColor.white.cgColor
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
        dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        balanceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50).isActive = true
        balanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addIncomeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        addIncomeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addExpenseButton.topAnchor.constraint(equalTo: addIncomeButton.bottomAnchor, constant: 50).isActive = true
        addExpenseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
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
