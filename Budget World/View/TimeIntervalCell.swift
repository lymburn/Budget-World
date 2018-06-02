//
//  TimeIntervalCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TimeIntervalCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let intervalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension TimeIntervalCell {
    fileprivate func setupViews() {
        addSubview(intervalLabel)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        intervalLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        intervalLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        intervalLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
