//
//  DataGeneratorService.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/6/23.
//

import Foundation
import SwiftUI
import Combine

class DataLoaderViewModel : ObservableObject {
    
    var databaseManager: DatabaseManager?
    var employeeRepository: EmployeeRepository?
    var expenseReportRepository: ReportsRepository?
    
    @Published var logInfo: String = ""
    
    func loadState (databaseManager: DatabaseManager,
          employeeRepository: EmployeeRepository,
          expenseReportRepository: ReportsRepository){
        self.databaseManager = databaseManager
        self.employeeRepository = employeeRepository
        self.expenseReportRepository = expenseReportRepository
    }
    
    func generateData () {
        logInfo = logInfo + "Starting Generation of Data\n\n"
        
        //get last six months to generate sample data from
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
       
        let calendar = Calendar.current
        let currentDate = Date()

        for monthsBack in 0...5 {
            if let date = calendar.date(byAdding: .month, value: -monthsBack, to: currentDate) {
                
                
                //generate data to put into the database
                let documentId = UUID().uuidString
                let reportDate = dateFormatter.string(from: date)
                let reportName = reportDate + " Expenses"
                let reportDescription = "Expense Report for \(reportDate)"
                let isCompleted = monthsBack > 1 ? true : false
                let status = isCompleted ? "Approved" : "Draft"
                var expenseAmount : Double = 0.0
                let reportForEmployee = employeeRepository?.authenticatedEmployee?.employee.email ?? ""
                
                logInfo += "\(reportDescription) \n\n"
            }
        }
    }
}
