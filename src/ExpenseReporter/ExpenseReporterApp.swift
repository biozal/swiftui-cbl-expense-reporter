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
    var userProfileRepository: UserProfileRepository
    
    init() {
        databaseManager = DatabaseManager()
        userProfileRepository = UserProfileRepository(databaseManager: databaseManager)
    }
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                MainView()
                    .environmentObject(databaseManager)
                    .environmentObject(authService)
                    .environmentObject(userProfileRepository)
            } else {
                AuthenticationView()
                    .environmentObject(databaseManager)
                    .environmentObject(authService)
                    .environmentObject(userProfileRepository)
                
            }
        }
    }
}
