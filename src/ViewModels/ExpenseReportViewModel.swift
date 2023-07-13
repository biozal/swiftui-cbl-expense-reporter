//
//  ExpenseReportViewModel.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/13/23.
//

import Foundation
import SwiftUI

class ExpenseReportViewModel : ObservableObject {
    var databaseManager: DatabaseManager?
    var employeeRepository: EmployeeRepository?
    var expenseReportRepository: ReportsRepository?
    
    
    func loadState (databaseManager: DatabaseManager,
        employeeRepository: EmployeeRepository,
        expenseReportRepository: ReportsRepository){
        
        self.databaseManager = databaseManager
        self.employeeRepository = employeeRepository
        self.expenseReportRepository = expenseReportRepository
    }
}
