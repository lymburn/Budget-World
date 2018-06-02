//
//  TimeIntervalsView.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

//View for choose the time interval to view for analytics
class TimeIntervalsMenu: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        timeIntervalCollectionView.register(TimeIntervalCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    let cellId = "cellId"
    let timeIntervalNames = ["This month", "3 months", "6 months"]
    
    lazy var timeIntervalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.black
        cv.layer.borderWidth = 1
        cv.layer.borderColor = UIColor.white.cgColor
        cv.layer.cornerRadius = 7
        return cv
    }()
    
    let slideMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(slideMenuPressed), for: .touchDown)
        return button
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TimeIntervalCell
        cell.intervalLabel.text = timeIntervalNames[indexPath.row]
        
        if indexPath.row == 1 {
            //Draw border on 2nd cell
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.white.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: timeIntervalCollectionView.frame.width/3, height: 29)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension TimeIntervalsMenu {
    fileprivate func setupViews() {
        backgroundColor = .black
        addSubview(slideMenu)
        addSubview(timeIntervalCollectionView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        slideMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        slideMenu.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        slideMenu.widthAnchor.constraint(equalToConstant: 25).isActive = true
        slideMenu.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        timeIntervalCollectionView.leadingAnchor.constraint(equalTo: slideMenu.trailingAnchor, constant: 24).isActive = true
        timeIntervalCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        timeIntervalCollectionView.heightAnchor.constraint(equalToConstant: 29).isActive = true
        timeIntervalCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

//MARK: Touch events
extension TimeIntervalsMenu {
    @objc func slideMenuPressed() {
        
    }
}
