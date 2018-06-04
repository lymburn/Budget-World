//
//  BaseChartController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BaseChartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "LLLL"
        return df
    }()
    
    let dateBar: DateBar = {
        let db = DateBar()
        db.translatesAutoresizingMaskIntoConstraints = false
        return db
    }()

    let chartTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Expenses"
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
