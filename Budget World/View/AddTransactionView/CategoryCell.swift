//
//  CategoryCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class CategoryCell: BaseTableViewCell {
    override func setupViews() {
        addSubview(icon)
        addSubview(categoryName)
        setupConstraints()
    }
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

//MARK: Setup constraints
extension CategoryCell {
    fileprivate func setupConstraints() {
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        categoryName.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16).isActive = true
        categoryName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        categoryName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryName.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
