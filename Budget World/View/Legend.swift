//
//  Legend.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class Legend: UIView, UICollectionViewDelegateFlowLayout  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        collectionView.register(LegendCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    let cellId = "cellId"
    let legendNames = ["General", "Eating Out", "Housing", "Fuel", "Transportation", "Entertainment", "Groceries", "Clothing","Education", "Hobbies", "Medical"]
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Legend"
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension Legend {
    fileprivate func setupViews() {
        addSubview(title)
        //addSubview(collectionView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
}

//Collection view delegate and data source
extension Legend: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legendNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LegendCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2, height: frame.height/6)
    }
}
