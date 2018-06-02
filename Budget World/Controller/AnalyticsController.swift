//
//  AnalyticsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import Charts

class AnalyticsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    let test: BarChartView = {
        let x = BarChartView()
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    
}

//MARK: Setup
extension AnalyticsController {
    fileprivate func setupViews() {
        view.addSubview(test)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        test.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        test.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        test.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        test.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
