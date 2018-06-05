//
//  SettingCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SettingCell: BaseTableViewCell {
    override func setupViews() {
        super.setupViews()
        addSubview(settingLabel)
        addSubview(icon)
        setupConstraints()
    }
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        return label
    }()
}

extension SettingCell {
    fileprivate func setupConstraints() {
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12).isActive = true
        settingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        settingLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
