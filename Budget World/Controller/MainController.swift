//
//  ViewController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-25.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(primary: UIColor.rgb(red: 86, green: 204, blue: 242), secondary: UIColor.rgb(red: 47, green: 128, blue: 237))
        setupViews()
    }
    
    let mainView: MainScreenView = {
        let view = MainScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

}

//MARK: Setup
extension MainController {
    fileprivate func setupViews() {
        view.backgroundColor = UIColor.clear
        view.addSubview(mainView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

