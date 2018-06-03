//
//  File.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-01.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import CoreData

class CreateSavingController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 15, green: 52, blue: 67)
        navigationItem.title = "Create Saving"
        
        createSavingView.delegate = self
        setupBarItems()
    }
    
    var savingAmount: NSDecimalNumber = 0
    
    let createSavingView: CreateSavingView = {
        let view = CreateSavingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension CreateSavingController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(createSavingView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        createSavingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createSavingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createSavingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        createSavingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func setupBarItems() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        cancelItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancelItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        doneItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = doneItem
    }
}

//MARK: Touch events
extension CreateSavingController {
    @objc func cancelButtonPressed() {
        let savingsController = SlideMenuController(mainViewController: SavingsController(), leftMenuViewController: SlideOptionsController())
        savingsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(savingsController, animated: true, completion: nil)
    }
    
    @objc func doneButtonPressed() {
        storeSaving()
        let savingsController = SlideMenuController(mainViewController: SavingsController(), leftMenuViewController: SlideOptionsController())
        savingsController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(savingsController, animated: true, completion: nil)
    }
}

//MARK: Create saving view delegate functions
extension CreateSavingController: CreateSavingViewDelegate {
    func amountPressed(amount: NSDecimalNumber) {
        savingAmount = amount
    }
}

//MARK: Storing into core data
extension CreateSavingController {
    fileprivate func storeSaving() {
        let context = AppDelegate.viewContext
        let saving = Saving(context: context)
        saving.amount = savingAmount
        saving.savingDescription = createSavingView.descriptionTextField.text ?? ""
        
        do {
            try saving.managedObjectContext?.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
