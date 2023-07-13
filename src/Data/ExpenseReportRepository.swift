//
//  ExpenseReportRepository.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/13/23.
//

import Foundation

class ExpenseReportRepository : ObservableObject {
    
    var databaseManager: DatabaseManager
    let _documentType = "expenseReport"
    
    init(databaseManager: DatabaseManager){
        self.databaseManager = databaseManager
    }
    
}
