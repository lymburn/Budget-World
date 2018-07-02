//
//  LineChartController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-06-03.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import Charts
import SlideMenuControllerSwift

class LineChartController: BaseChartController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.chartTitle.text = "Balance Over Time"
        dateBar.delegate = self
        setupViews()
        populateDataSet()
        setChart(values: balances)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.setValue(Int(UIInterfaceOrientation.landscapeLeft.rawValue), forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Change to portrait if moving away
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    var currentMonth: Date!
    var balances = [Double]()
    
    let lineChart: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.chartDescription?.text = ""
        chart.noDataText = "No expenses recorded"
        chart.noDataTextColor = .orange
        chart.legend.enabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.axisMinimum = 1.0
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.spaceBottom = 0.0
        return chart
    }()
    
    let pieChartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Pie Chart"), for: .normal)
        button.addTarget(self, action: #selector(pieChartPressed), for: .touchDown)
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
        chartTitle.topAnchor.constraint(equalTo: dateBar.bottomAnchor, constant: 8).isActive = true
        chartTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lineChart.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: 16).isActive = true
        lineChart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
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
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.colors = [UIColor.rgb(red: 43, green: 132, blue: 210)]
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        lineChart.data = lineChartData
    }
    
    fileprivate func populateDataSet() {
        var dayBalance: NSDecimalNumber = 0
        //Clear balances first
        balances.removeAll()
        //Loop through the days of the current month
        let calendar = Calendar.current
        var startDate = currentMonth
        var components = DateComponents()
        components.month = 1
        let currentDateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startDateComponents = Calendar.current.dateComponents([.year, .month], from: startDate!)
        var endOfMonth = Calendar.current.date(byAdding: components, to: currentMonth)!
        
        //If the current display is for the current month, only show data up till the current day in the month. Else, show the entire month
        if currentDateComponents.month == startDateComponents.month && currentDateComponents.year == startDateComponents.year {
            endOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year,.month, .day], from: Date()))!
        }
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
        populateDataSet()
        setChart(values: balances)
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
        populateDataSet()
        setChart(values: balances)
    }
}

//MARK: Touch events
extension LineChartController {
    @objc func pieChartPressed() {
        let pieChartController = SlideMenuController(mainViewController: PieChartController(), leftMenuViewController: SlideOptionsController())
        present(pieChartController, animated: true, completion: nil)
    }
}
