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
        //Lock to landscape
        //UIDevice.current.setValue(Int(UIInterfaceOrientation.landscapeLeft.rawValue), forKey: "orientation")
        setChart(dataPoints: months, values: unitsSold)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Change to portrait if moving away
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    var currentMonth: Date!
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    override var shouldAutorotate: Bool {
        return true
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
        legend.topAnchor.constraint(equalTo: pieChart.bottomAnchor, constant: 8).isActive = true
        legend.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    fileprivate func setDefaultMonth() {
        //Set default to current month
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        currentMonth = Calendar.current.date(from: components)!
        dateBar.dateLabel.text = dateFormatter.string(from: currentMonth)
    }
    
    fileprivate func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = colors
        chartDataSet.drawValuesEnabled = false
        chartDataSet.drawIconsEnabled = false
        let chartData = PieChartData(dataSets: [chartDataSet])
        pieChart.data = chartData
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

