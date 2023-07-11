//
//  ContentView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/25/23.
//

import SwiftUI

struct MainView: View {
    
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @EnvironmentObject var employeeRepository : EmployeeRepository
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var navigationSelectionService: NavigationSelectionService
    
    @State var navigationMenuService = NavigationMenuService()
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
                                    if let data =  employeeRepository.authenticatedEmployee?.imageData
                                    {
                                        if let uiImage = UIImage(data:  data) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                                .clipShape(Circle())
                                        }

                                        
                                    } else {
                                        Image(systemName: "person.circle.fill")

                                    }
                                    VStack(alignment: .leading){
                                        Text(employeeRepository.authenticatedEmployee?.employee.fullName() ?? "")
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
                    employeeRepository.authenticatedEmployee = nil
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
                    .environmentObject(employeeRepository)
            
            case .developerList:
                DeveloperView()
                    .environmentObject(employeeRepository)
                    .environmentObject(databaseManager)
            case .replicationStatus:
                ReplicationView()
            default:
                ReportsView(navigationMenuService: navigationMenuService)
                    .environmentObject(navigationSelectionService)
            }
        } detail: {
            switch (selection?.routableView){
            case .dataGenerator:
                DataLoaderView()
                    .environmentObject(databaseManager)
                    .environmentObject(employeeRepository)
            case .databaseInformation:
                DatabaseInfoView()
            case .expenseReport:
                ExpenseReportView()
            default:
                EmptyView()
            }
        }
        .environmentObject(authenticationService)
    }
}
#Preview {
    MainView()
}
