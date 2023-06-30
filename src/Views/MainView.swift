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
    @EnvironmentObject var userProfileRepository : UserProfileRepository
    @EnvironmentObject var databaseManager: DatabaseManager
    
    @State private var selection: NavigationMenuItem?
    @State private var preferredColumn = NavigationSplitViewColumn.content
    
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List(navigationMenuService.menuItems, id:\.id, selection: $selection) { menuItem in
                if (menuItem.name == "User Profile"){
                    Section(header: Text("User Profile")) {
                        NavigationLink(value: menuItem) {
                            VStack{
                                HStack{
                                    Image(systemName: "person.circle.fill")
                                    VStack(alignment: .leading){
                                        Text(userProfileRepository.authenticatedUserProfile?.fullName() ?? "")
                                            .font(.subheadline)
                                        
                                        Text(authenticationService.username)
                                            .font(.caption)
                                        
                                    }
                                }
                            }
                        }
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
                    userProfileRepository.authenticatedUserProfile = nil
                }){
                    HStack{
                        Image(systemName: "arrow.right.square")
                        Text("Logoff")
                    }
                }.buttonStyle(GrowingButton())
            }

            
            
        } content: {
            ContentView(selection: selection)
                .environmentObject(authenticationService)
                .environmentObject(userProfileRepository)
        } detail: {
            DetailView(selection: selection)
        }
        .environmentObject(authenticationService)
    }
}
#Preview {
    MainView()
}
