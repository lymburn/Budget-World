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
    case housing = 4
    case fuel = 5
    case transportation = 6
    case eatingOut = 7
    case entertainment = 8
    case holiday = 9
    case groceries = 10
    case clothing = 11
    case medical = 12
    case education = 13
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
