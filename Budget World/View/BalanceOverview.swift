//
//  BalanceOverview.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BalanceOverview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        //Draw separator line under balance
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x:30, y: 0))
        aPath.addLine(to: CGPoint(x: frame.width - 30, y: 0))
        aPath.close()
        UIColor.rgb(red: 51, green: 51, blue: 51).set()
        aPath.stroke()
        aPath.fill()
    }
    
    let balanceLabel : BudgetLabel = {
        let label = BudgetLabel()
        label.textColor = UIColor.rgb(red: 43, green: 132, blue: 210)
        label.text = "Balance"
        return label
    }()
    
    let balanceAmount: BudgetLabel = {
        let label = BudgetLabel()
        label.textAlignment = .right
        label.textColor = UIColor.rgb(red: 43, green: 132, blue: 210)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension BalanceOverview {
    fileprivate func setupViews() {
        addSubview(balanceLabel)
        addSubview(balanceAmount)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        balanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        balanceAmount.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        balanceAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }
}

