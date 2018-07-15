//
//  BudgetWorldTest.swift
//  BudgetWorldTest
//
//  Created by Eugene Lu on 2018-07-14.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import XCTest
@testable import Budget_World

class BudgetWorldTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let currencies = ["USD", "CAD", "EUR", "CNY", "GBP", "JPY", "RUB", "KRW", "IDR", "BRL", "PKR", "BDT", "NGN", "MXN", "VND", "PHP",
                              "ETB", "EGP", "YTL", "IRR", "THB", "CDF", "MMK", "ZAR", "UAH", "COP", "ARS", "PLN", "MAD", "NPR", "VEF", "MYR"]
            
            DispatchQueue.global(qos: .userInitiated).async {
                for i in currencies {
                    self.getSymbolForCurrencyCode(code: i)
                }
            }
        }
    }
    
    fileprivate func getSymbolForCurrencyCode(code: String) -> String? {
        guard let identifier = Locale.availableIdentifiers.first(where: { Locale(identifier: $0).currencyCode == code }) else { return nil }
        return Locale(identifier: identifier).currencySymbol
    }
    
}
