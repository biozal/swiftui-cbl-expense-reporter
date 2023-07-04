//
//  ContentView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/25/23.
//

import SwiftUI

struct MainView: View {
    
    var navigationMenuService = NavigationMenuService()
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @EnvironmentObject var userProfileRepository : EmployeeRepository
    @EnvironmentObject var databaseManager: DatabaseManager
    
    @State private var selection: NavigationMenuItem?
    @State private var preferredColumn = NavigationSplitViewColumn.content
    
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List(navigationMenuService.menuItems, id:\.id, selection: $selection) { menuItem in
                if (menuItem.routableView == .employeeProfile){
                    Section(header: Text("User Profile")) {
                        NavigationLink(value: menuItem) {
                            VStack{
                                HStack{
                                    Image(systemName: "person.circle.fill")
                                    VStack(alignment: .leading){
                                        Text(userProfileRepository.authenticatedEmployee?.fullName() ?? "")
                                            .font(.subheadline)
                                        
                                        Text(authenticationService.username)
                                            .font(.caption)
                                        
                                    }
                                }
                            }
                        }
                        .isDetailLink(false)
                    }
                }
                else {
                    NavigationLink(value: menuItem) {
                        HStack {
                            menuItem.icon
                            Text(menuItem.name)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Expense Reporter")
            .navigationBarTitleDisplayMode(.inline)
            
            Section() {
                Button(action: {
                    databaseManager.closeDatabase()
                    authenticationService.isAuthenticated = false
                    userProfileRepository.authenticatedEmployee = nil
                }){
                    HStack{
                        Image(systemName: "arrow.right.square")
                        Text("Logoff")
                    }
                }.buttonStyle(GrowingButton())
            }
        } content: {
            switch selection?.routableView {
            case .employeeProfile:
                EmployeeProfileView(selectedNavigationMenuItem: $selection)
                    .environmentObject(userProfileRepository)
            case .reports:
                ReportsView()
            case .developerList:
                DeveloperView()
            case .replicationStatus:
                ReplicationView()
            default:
                ReportsView()
            }
        } detail: {
            if (selection?.routableView == RoutableView.reports){
                ExpenseReportView()
            }
        }
        .environmentObject(authenticationService)
    }
}
#Preview {
    MainView()
}
