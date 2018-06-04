//
//  EditSavingController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class EditSavingController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let editSavingView: EditSavingView = {
        let view = EditSavingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension EditSavingController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(editSavingView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        editSavingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editSavingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        editSavingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        editSavingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
