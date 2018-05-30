//
//  TransactionsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TransactionsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        transactionsView.dateBar.delegate = self
    }
    
    var currentMonth: Date!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "LLLL"
        return df
    }()
    
    let transactionsView : TransactionsView = {
        let view = TransactionsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension TransactionsController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(transactionsView)
        setupConstraints()
        setDefaultMonth()
    }
    
    fileprivate func setupConstraints() {
        transactionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        transactionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        transactionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        transactionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        transactionsView.dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        print(dateFormatter.string(from: currentMonth))
    }
}

//MARK: Date bar delegate methods
extension TransactionsController: DateBarDelegate {
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
        
    }
    
    func nextMonthPressed() {
        
    }
}
