//
//  ExpenseReporterApp.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/25/23.
//

import SwiftUI

@main
struct ExpenseReporterApp: App {
    @StateObject var authService = AuthenticationService()

    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                MainView().environmentObject(authService)
            } else {
                AuthenticationView().environmentObject(authService)
            }
        }
    }
    

}
