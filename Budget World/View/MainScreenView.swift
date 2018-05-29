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
    func previousMonthPressed()
    func nextMonthPressed()
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let previousMonth: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Left Arrow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousMonthPressed), for: .touchDown)
        return button
    }()
    
    let nextMonth: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Right Arrow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextMonthPressed), for: .touchDown)
        return button
    }()
    
    let addIncomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Income", for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2/UIScreen.main.nativeScale
        button.contentEdgeInsets = UIEdgeInsetsMake(4, 20, 4, 20)
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addIncomePressed), for: .touchDown)
        return button
    }()
    
    let addExpenseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Expense", for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2/UIScreen.main.nativeScale
        button.contentEdgeInsets = UIEdgeInsetsMake(4, 16,4, 16)
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
        addSubview(previousMonth)
        addSubview(nextMonth)
        addSubview(addIncomeButton)
        addSubview(addExpenseButton)
        addSubview(slideMenu)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        
        previousMonth.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        previousMonth.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        previousMonth.widthAnchor.constraint(equalToConstant: 42).isActive = true
        previousMonth.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        nextMonth.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        nextMonth.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        nextMonth.widthAnchor.constraint(equalToConstant: 42).isActive = true
        nextMonth.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: previousMonth.trailingAnchor, constant: 32).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: nextMonth.leadingAnchor, constant: -32).isActive = true
        
        balanceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50).isActive = true
        balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addIncomeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        addIncomeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addExpenseButton.topAnchor.constraint(equalTo: addIncomeButton.bottomAnchor, constant: 50).isActive = true
        addExpenseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        slideMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        slideMenu.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 30).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
    
    @objc func previousMonthPressed() {
        delegate?.previousMonthPressed()
    }
    
    @objc func nextMonthPressed() {
        delegate?.nextMonthPressed()
    }
}
