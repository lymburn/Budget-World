//
//  BudgetLabel.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-29.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

//Base label class for displaying budget info
class BudgetLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        self.textAlignment = .left
        self.font = UIFont(name: "OpenSans-Regular", size: 16)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
