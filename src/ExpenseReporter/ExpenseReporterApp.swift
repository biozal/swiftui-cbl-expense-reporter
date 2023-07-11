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
    
    var userProfileRepository: EmployeeRepository
    
    init() {
        databaseManager = DatabaseManager()
        userProfileRepository = EmployeeRepository(databaseManager: databaseManager)
    }
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                MainView()
                    .environmentObject(databaseManager)
                    .environmentObject(authService)
                    .environmentObject(userProfileRepository)
                    .environmentObject(navigationSelectionService)
            } else {
                AuthenticationView()
                    .environmentObject(databaseManager)
                    .environmentObject(authService)
                    .environmentObject(userProfileRepository)
                
            }
        }
    }
}
