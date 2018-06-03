//
//  PieChartController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-02.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import Charts

class PieChartController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        dateBar.delegate = self
        setLegendColors()
        getExpenseTransactions()
        
        if expensesExist() {
            chartTitle.alpha = 1
            setChart(values: expensePercentages)
        }else {
            chartTitle.alpha = 0
            pieChart.clear()
        }
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
        chart.noDataText = "No expenses recorded"
        chart.noDataTextColor = .orange
        return chart
    }()
    
    let chartTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Expenses"
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.textColor = UIColor.rgb(red: 51, green: 51, blue: 51)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let legend: Legend = {
        let legend = Legend()
        legend.translatesAutoresizingMaskIntoConstraints = false
        return legend
    }()
    
    fileprivate func expensesExist() -> Bool {
        //Check if there is at least 1 expense inside expense percentages
        for i in 0..<expensePercentages.count {
            if expensePercentages[i] != 0 {
                //Atleast 1 expense
                return true
            }
        }
        return false
    }
}

//MARK: Setup
extension PieChartController {
    fileprivate func setupViews() {
        view.addSubview(chartTitle)
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
        
        chartTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chartTitle.topAnchor.constraint(equalTo: dateBar.bottomAnchor, constant: 24).isActive = true
        chartTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pieChart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pieChart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pieChart.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: 8).isActive = true
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
        legendColors.append(UIColor(rgb: 0x3498DB))
        legendColors.append(UIColor(rgb: 0x00BDE8))
        legendColors.append(UIColor(rgb: 0x00DEDD))
        legendColors.append(UIColor(rgb: 0x00A6FC))
        legendColors.append(UIColor(rgb: 0x90EE90))
        legendColors.append(UIColor(rgb: 0x36B27C))
        legendColors.append(UIColor(rgb: 0x007C4B))
        legendColors.append(UIColor(rgb: 0xFC4C51))
        legendColors.append(UIColor(rgb: 0xFFBCD9))
        legendColors.append(UIColor(rgb: 0xCD0000))
        legendColors.append(UIColor(rgb: 0xFF8496))
        
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
extension PieChartController {
    fileprivate func getExpenseTransactions() {
        expenseTransactions = TransactionManager.fetchTransactions(incomeType: false, currentMonth: currentMonth)
        let totalExpense = TransactionManager.calculateBalance(expenseTransactions)
        var expenseForCategories = [NSDecimalNumber].init(repeating: 0, count: 11)
        
        //Sum up total expense for each category and insert into array
        for transaction in expenseTransactions {
            expenseForCategories[Int(transaction.category) - 3] = NSDecimalNumber(decimal: expenseForCategories[Int(transaction.category) - 3].decimalValue + (transaction.amount?.decimalValue)!)
        }
        
        //Calculate the percentages and insert into array
        for i in 0..<expenseForCategories.count {
            let decimalPercent: NSDecimalNumber = NSDecimalNumber(decimal: expenseForCategories[i].decimalValue/totalExpense.decimalValue)
            let percent: Double = abs(Double(truncating: decimalPercent))*100
            
            expensePercentages[i] = percent.isNaN ? 0 : percent
        }
    }
}

//MARK: Date bar delegate methods
extension PieChartController: DateBarDelegate {
    
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
        let currentYear = Calendar.current.dateComponents([.year], from: Date())
        var previousMonthComponents = DateComponents()
        previousMonthComponents.month = -1
        currentMonth = Calendar.current.date(byAdding: previousMonthComponents, to: currentMonth)
        let currentMonthComponents = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        //Check if year has changed
        if currentYear.year! == currentMonthComponents.year! {
            dateFormatter.dateFormat = "MMM"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        getExpenseTransactions()
        
        if expensesExist() {
            chartTitle.alpha = 1
            setChart(values: expensePercentages)
        }else {
            chartTitle.alpha = 0
            pieChart.clear()
        }
    }
    
    func nextMonthPressed() {
        let currentYear = Calendar.current.dateComponents([.year], from: Date())
        var nextMonthComponents = DateComponents()
        nextMonthComponents.month = 1
        currentMonth = Calendar.current.date(byAdding: nextMonthComponents, to: currentMonth)
        let currentMonthComponents = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        //Check if year has changed
        if currentYear.year! == currentMonthComponents.year! {
            dateFormatter.dateFormat = "MMM"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        } else {
            //If year changed, show year as well
            dateFormatter.dateFormat = "MMM YYYY"
            dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
        }
        getExpenseTransactions()
        if expensesExist() {
            chartTitle.alpha = 1
            setChart(values: expensePercentages)
        }else {
            chartTitle.alpha = 0
            pieChart.clear()
        }
    }
}

