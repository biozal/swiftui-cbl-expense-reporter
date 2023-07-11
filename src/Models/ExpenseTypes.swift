//
//  ExpenseTypes.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/6/23.
//

import Foundation

struct ExpenseTypeDao: Codable {
    let item: ExpenseTypes
}

struct ExpenseTypes: Codable {
    let documentId: String
    let documentType: String
    let expenseTypes: [ExpenseType]
    
    init (documentId: String, expenseTypes: [ExpenseType]) {
        self.documentId = documentId
        self.expenseTypes = expenseTypes
        self.documentType = "expenseTypes"
    }
}

struct ExpenseType: Codable {
    let name: String
    let subTypes: [String]
}
