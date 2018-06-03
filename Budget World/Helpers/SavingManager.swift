//
//  SavingManager.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import CoreData

class SavingManager {
    static func fetchSavings() -> [Saving] {
        let savings: [Saving]
        let request: NSFetchRequest<Saving> = Saving.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: true, selector: nil)]
        request.predicate = nil
        
        let context = AppDelegate.viewContext
        do {
            try savings = context.fetch(request)
        } catch {
            fatalError("Failure to fetch request: \(error)")
        }
        
        return savings
    }
}
