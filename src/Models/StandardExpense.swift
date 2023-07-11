//
//  StandardExpense.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/6/23.
//

import Foundation

struct StandardExpense: Codable {
    let expenseId: String
    let reportId: String
    let description: String
    let date: Date
    let expenseTypeCategory: String
    let expenseType: String
    let documentType: String
    let createdBy: String
    let amount: Double

    init(expenseId: String = "",
         reportId: String = "",
         description: String = "",
         date: Date = Date.now,
         expenseTypeCategory: String = "",
         expenseType: String = "",
         documentType: String = "",
         createdBy: String = "",
         amount: Double = 0.00) {

        self.expenseId = expenseId
        self.reportId = reportId
        self.description = description
        self.date = date
        self.expenseTypeCategory = expenseTypeCategory
        self.expenseType = expenseType
        self.documentType = documentType
        self.createdBy = createdBy
        self.amount = amount
    }
}
