//
//  LineChartController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import Charts

class LineChartController: BaseChartController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.chartTitle.text = "Balance Over Time"
        dateBar.delegate = self
        setupViews()
        populateDataSet()
        setChart(values: balances)
    }
    
    var currentMonth: Date!
    var balances = [Double]()
    var dayBalance: NSDecimalNumber = 0
    
    let lineChart: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.chartDescription?.text = ""
        chart.noDataText = "No expenses recorded"
        chart.noDataTextColor = .orange
        chart.legend.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        return chart
    }()
    
    let pieChartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Pie Chart"), for: .normal)
        return button
    }()
}

//MARK: Setup
extension LineChartController {
    fileprivate func setupViews() {
        view.addSubview(chartTitle)
        view.addSubview(dateBar)
        view.addSubview(lineChart)
        dateBar.addSubview(pieChartButton)
        setupConstraints()
        setDefaultMonth()
    }
    
    fileprivate func setupConstraints() {
        dateBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        pieChartButton.centerYAnchor.constraint(equalTo: dateBar.centerYAnchor).isActive = true
        pieChartButton.trailingAnchor.constraint(equalTo: dateBar.trailingAnchor, constant: -12).isActive = true
        pieChartButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        pieChartButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        chartTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chartTitle.bottomAnchor.constraint(equalTo: lineChart.topAnchor, constant: -16).isActive = true
        chartTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lineChart.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lineChart.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
    
    fileprivate func setChart(values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i+1), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Balance")
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawValuesEnabled = false
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        lineChart.data = lineChartData
    }
    
    fileprivate func populateDataSet() {
        //Loop through the days of the current month
        let calendar = Calendar.current
        var startDate = currentMonth
        var components = DateComponents()
        components.month = 1
        let endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        
        while startDate! <= endOfMonth {
            let dayTransactions = TransactionManager.fetchTransactionsByDay(day: startDate!)
            dayBalance = NSDecimalNumber(decimal: dayBalance.decimalValue + TransactionManager.calculateBalance(dayTransactions).decimalValue)
            balances.append(Double(truncating: dayBalance))
            startDate! = calendar.date(byAdding: .day, value: 1, to: startDate!)!
        }
    }
}


//MARK: Date bar delegate methods
extension LineChartController: DateBarDelegate {
    
    func slideMenuPressed() {
        self.slideMenuController()?.openLeft()
    }
    
    func previousMonthPressed() {
    }
    
    func nextMonthPressed() {
    }
}


