//
//  BaseCollectionViewCell.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BaseCollectionViewCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
