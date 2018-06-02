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
    let legendNames = ["General", "Eating out", "Housing", "Fuel", "Transportation", "Entertainment", "Groceries", "Clothing","Education", "Hobbies", "Medical"]
    let legendIconNames = ["GeneralC", "Eating OutC", "HousingC", "FuelC", "TransportationC", "EntertainmentC", "GroceriesC", "ClothingC","EducationC", "HobbiesC", "MedicalC"]
    var legendColors: [UIColor]!
    
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
        addSubview(collectionView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
}

//Collection view delegate and data source
extension Legend: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legendNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LegendCell
        cell.title.text = legendNames[indexPath.row]
        cell.icon.image = UIImage(named: legendIconNames[indexPath.row])
        cell.title.textColor = legendColors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/6)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
