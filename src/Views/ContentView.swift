//
//  ContentView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationService: AuthenticationService
    var selection: NavigationMenuItem?
    
    var body: some View {
        switch selection?.name {
        case "User Profile":
            UserProfileView()
        case "Expense Report":
            ReportsView()
        case "Developer":
            DeveloperView()
        case "Replication":
            DeveloperView()
        default:
            ExpenseReportView()
        }
    }
       
}

#Preview {
    ContentView()
}
