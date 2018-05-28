//
//  Helper Functions.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-28.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation

func getCategoryType(categoryName: String) -> CategoryType {
    var categoryType: CategoryType
    switch categoryName {
        case "Salary": categoryType = .salary
        case "Investment": categoryType = .investment
        case "Sale": categoryType = .sale
        case "General": categoryType = .general
        case "Eating Out": categoryType = .eatingOut
        case "Housing": categoryType = .housing
        case "Fuel": categoryType = .fuel
        case "Transportation": categoryType = .transporation
        case "Entertainment": categoryType = .entertainment
        case "Groceries": categoryType = .groceries
        case "Clothing": categoryType = .clothing
        case "Education": categoryType = .education
        case "Hobbies": categoryType = .hobbies
        case "Medical": categoryType = .medical
        default: categoryType = .general
    }
    return categoryType
}
