//
//  ExpenseReporterApp.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/25/23.
//

import SwiftUI
import Combine

@main
struct ExpenseReporterApp: App {
    
    var databaseManager: DatabaseManager
    
    @StateObject var authService = AuthenticationService()
    @StateObject var navigationSelectionService =  NavigationSelectionService()
    
    var employeeRepository: EmployeeRepository
    var expenseReportRepository: ExpenseReportRepository
    
    init() {
        databaseManager = DatabaseManager()
        employeeRepository = EmployeeRepository(databaseManager: databaseManager)
        expenseReportRepository = ExpenseReportRepository(databaseManager: databaseManager)
    }
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                MainView()
                    .environmentObject(databaseManager)
                    .environmentObject(authService)
                    .environmentObject(employeeRepository)
                    .environmentObject(expenseReportRepository)
                    .environmentObject(navigationSelectionService)
            } else {
                AuthenticationView()
                    .environmentObject(databaseManager)
                    .environmentObject(authService)
                    .environmentObject(employeeRepository)
                
            }
        }
    }
}
