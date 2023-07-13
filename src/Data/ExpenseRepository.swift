//
//  ExpenseRepository.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/13/23.
//

import Foundation

class ExpenseRepository : ObservableObject {
    
    var databaseManager: DatabaseManager
    let _documentType = "expense"
    
    init(databaseManager: DatabaseManager){
        self.databaseManager = databaseManager
    }
}
