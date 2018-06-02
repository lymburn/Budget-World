//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-01.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class CreateSavingController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let createSavingView: CreateSavingView = {
        let view = CreateSavingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension CreateSavingController {
    fileprivate func setupViews() {
        view.addSubview(createSavingView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        createSavingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createSavingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createSavingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        createSavingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
