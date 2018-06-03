//
//  AnalyticsController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import Charts

class AnalyticsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        dateBar.delegate = self
        setLegendColors()
        getExpenseTransactions()
        setChart(values: expensePercentages)
    }
    
    var currentMonth: Date!
    var legendColors = [UIColor]()
    var expensePercentages = [Double].init(repeating: 0, count: 11)
    var expenseTransactions: [Transaction]!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "LLLL"
        return df
    }()
    
    let dateBar: DateBar = {
        let db = DateBar()
        db.translatesAutoresizingMaskIntoConstraints = false
        return db
    }()
    
    let pieChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.chartDescription?.text = ""
        chart.legend.enabled = false
        chart.drawHoleEnabled = false
        return chart
    }()
    
    let legend: Legend = {
        let legend = Legend()
        legend.translatesAutoresizingMaskIntoConstraints = false
        return legend
    }()
}

//MARK: Setup
extension AnalyticsController {
    fileprivate func setupViews() {
        view.addSubview(dateBar)
        view.addSubview(pieChart)
        view.addSubview(legend)
        setupConstraints()
        setDefaultMonth()
    }
    
    fileprivate func setupConstraints() {
        dateBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        pieChart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pieChart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pieChart.topAnchor.constraint(equalTo: dateBar.bottomAnchor, constant: 32).isActive = true
        pieChart.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        legend.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        legend.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        legend.topAnchor.constraint(equalTo: pieChart.bottomAnchor, constant: 0).isActive = true
        legend.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
    
    fileprivate func setLegendColors() {
        legendColors.append(UIColor.rgb(red: 46, green: 204, blue: 113))
        legendColors.append(UIColor.rgb(red: 149, green: 165, blue: 166))
        legendColors.append(UIColor.rgb(red: 243, green: 221, blue: 18))
        legendColors.append(UIColor.black)
        legendColors.append(UIColor.rgb(red: 52, green: 152, blue: 219))
        legendColors.append(UIColor.rgb(red: 231, green: 76, blue: 60))
        legendColors.append(UIColor.rgb(red: 22, green: 160, blue: 54))
        legendColors.append(UIColor.rgb(red: 142, green: 68, blue: 173))
        legendColors.append(UIColor.rgb(red: 44, green: 62, blue: 80))
        legendColors.append(UIColor.rgb(red: 64, green: 41, blue: 185))
        legendColors.append(UIColor.rgb(red: 255, green: 0, blue: 0))
        
        
        legend.legendColors = legendColors
    }
    
    fileprivate func setChart(values: [Double]) {
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Expenses")
        chartDataSet.colors = legendColors
        chartDataSet.drawValuesEnabled = true
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)

        let chartData = PieChartData(dataSets: [chartDataSet])
        pieChart.data = chartData
    }
}

//MARK: Expense calculations
extension AnalyticsController {
    fileprivate func getExpenseTransactions() {
        expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        var totalExpense = TransactionManager.calculateBalance(expenseTransactions)
        var expenseForCategories = [NSDecimalNumber].init(repeating: 0, count: 11)
        
        //Sum up total expense for each category and insert into array
        for transaction in expenseTransactions {
            expenseForCategories[Int(transaction.category)] = NSDecimalNumber(decimal: expenseForCategories[Int(transaction.category)].decimalValue + (transaction.amount?.decimalValue)!)
        }
        
        //Calculate the percentages and insert into array
        for i in 0..<expenseForCategories.count {
            let decimalPercent: NSDecimalNumber = NSDecimalNumber(decimal: expenseForCategories[i].decimalValue/totalExpense.decimalValue)
            let percent: Double = abs(Double(truncating: decimalPercent))*100
            expensePercentages[i] = percent
        }
    }
}

//MARK: Date bar delegate methods
extension AnalyticsController: DateBarDelegate {
    
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
    }
    
    func nextMonthPressed() {
    }
}

