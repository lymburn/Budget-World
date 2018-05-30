//
//  DateBar.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol DateBarDelegate: class {
    func slideMenuPressed()
    func previousMonthPressed()
    func nextMonthPressed()
}

class DateBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: DateBarDelegate? = nil
    
    let slideMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(slideMenuPressed), for: .touchDown)
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension DateBar {
    fileprivate func setupViews() {
        backgroundColor = .black
        addSubview(slideMenu)
        addSubview(dateLabel)
        addSubview(previousMonth)
        addSubview(nextMonth)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        slideMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        slideMenu.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        previousMonth.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        previousMonth.leadingAnchor.constraint(equalTo: slideMenu.trailingAnchor, constant: 42).isActive = true
        previousMonth.widthAnchor.constraint(equalToConstant: 22).isActive = true
        previousMonth.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        nextMonth.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nextMonth.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        nextMonth.widthAnchor.constraint(equalToConstant: 22).isActive = true
        nextMonth.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: previousMonth.trailingAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: nextMonth.leadingAnchor, constant: -16).isActive = true
    }
}

//MARK: Touch events
extension DateBar {
    @objc func previousMonthPressed() {
        delegate?.previousMonthPressed()
    }
    
    @objc func nextMonthPressed() {
        delegate?.nextMonthPressed()
    }
    
    @objc func slideMenuPressed() {
        delegate?.slideMenuPressed()
    }
}
