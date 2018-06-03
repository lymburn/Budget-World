//
//  LegendCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class LegendCell: BaseCollectionViewCell {
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Legend"
        
        label.font = UIFont(name: "OpenSans-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        addSubview(icon)
        addSubview(title)
        setupConstraints()
    }
}

//MARK: Constraints
extension LegendCell {
    fileprivate func setupConstraints() {
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width/5).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
}
