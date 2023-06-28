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
                                        Text("Full Name")
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
                    authenticationService.isAuthenticated = false
                }){
                    HStack{
                        Image(systemName: "arrow.right.square")
                        Text("Logoff")
                    }
                }.buttonStyle(GrowingButton())
            }

            
            
        } content: {
            ContentView(selection: selection).environmentObject(authenticationService)
        } detail: {
            DetailView(selection: selection)
        }
        .environmentObject(authenticationService)
    }
}
#Preview {
    MainView()
}
