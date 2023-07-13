//
//  DetailView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI

struct ExpenseReportView: View {
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var employeeRepository : EmployeeRepository
    @EnvironmentObject var expenseReportRepository: ReportsRepository

    var body: some View {
        Text("Expense Detail View")
    }
}

#Preview {
    ExpenseReportView()
}
