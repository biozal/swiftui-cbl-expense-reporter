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
    
    var body: some View {
        NavigationSplitView {
            //TODO this vstack feels wrong, probably better way of doing this, research
            
            List(navigationMenuService.menuItems, id:\.id, selection: $selection) { menuItem in
                NavigationLink(value: menuItem) {
                    if (menuItem.name == "User Profile"){
                        VStack{
                            HStack{
                                Image(systemName: "person.circle.fill")
                                VStack{
                                    Text("Full Name")
                                        .font(.title)
                                    
                                    Text(authenticationService.username)
                                        .font(.caption)
                                    
                                }
                            }
                        }
                    }
                    else {
                        HStack {
                            menuItem.icon
                            Text(menuItem.name)
                        }
                    }
                }
            }
            .navigationTitle("Expense Reporter")
            .listStyle(SidebarListStyle())
            
            Button(action: {
                authenticationService.isAuthenticated = false
            }){
                HStack{
                    Image(systemName: "arrow.right.square")
                    Text("Logoff")
                }
            }.buttonStyle(GrowingButton())
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
