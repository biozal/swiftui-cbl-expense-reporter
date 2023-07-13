//
//  ExpenseReport.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import Foundation

class Report
    : Identifiable {
    //TODO
    //might need to format dates
    //let formatter = DateFormatter()
    //formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //let dateString = formatter.string(from: currentDate)

    let documentId: String
    var name: String
    var description: String
    let isComplete: Bool
    let documentType: String = "expenseReport"
    var reportDate: Date
    let amount: Double
    var status: String
    let department: String
    let reportForEmployee: String
    let createdBy: String
    var updatedDate: Date
    var approvalManager: Manager?

    init(reportId: String = "",
         name: String = "",
         description: String = "",
         isComplete: Bool = false,
         reportDate: Date = Date.now,
         amount: Double = 0.00,
         status: String = "Draft",
         department: String = "",
         createdBy: String = "",
         reportForEmployee: String = "",
         updatedDate: Date = Date.now,
         approvalManager: Manager? = nil) {
        
        self.documentId = reportId
        self.name = name
        self.description = description
        self.isComplete = isComplete
        self.reportDate = reportDate
        self.amount = amount
        self.status = status
        self.department = department
        self.createdBy = createdBy
        self.updatedDate = updatedDate
        self.reportForEmployee = reportForEmployee
        self.approvalManager = approvalManager
    }
}
