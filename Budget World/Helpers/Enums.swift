//
//  Enums.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation

enum TransactionType {
    case income
    case expense
}

@objc enum CategoryType: Int32 {
    case salary = 0
    case investment = 1
    case sale = 2
    case general = 3
    case eatingOut = 4
    case housing = 5
    case fuel = 6
    case transporation = 7
    case entertainment = 8
    case groceries = 9
    case clothing = 10
    case education = 11
    case hobbies = 12
    case medical = 13
}

@objc enum RecurringPeriod: Int32 {
    case never = 0
    case weekly = 1
    case biWeekly = 2
    case monthly = 3
    case biMonthly = 4
    case quarterly = 5
    case semiAnnually = 6
    case annually = 7
}
