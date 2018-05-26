//
//  slideOptionCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SlideOptionCell : BaseTableViewCell {
    override func setupViews() {
        super.setupViews()
        addSubview(title)
        addSubview(icon)
        setConstraints()
    }
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

//MARK: Constraints
extension SlideOptionCell {
    fileprivate func setConstraints() {
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
