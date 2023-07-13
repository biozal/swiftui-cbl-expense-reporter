//
//  DeveloperView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var employeeRepository: EmployeeRepository
    @EnvironmentObject var navigationSelectionService: NavigationSelectionService
    @EnvironmentObject var navigationMenuService: NavigationMenuService
    
    var viewModel = DeveloperViewModel()
   
    var body: some View {
        VStack{
            NavigationLink(destination:
                            DataLoaderView()
                .environmentObject(databaseManager)
                .environmentObject(employeeRepository)
            ){
                Text("Generate Sample Data")
            }.buttonStyle(GrowingButton())
            .padding(.bottom, 44)
            
            NavigationLink(destination:
                            DatabaseInfoView()
                .environmentObject(databaseManager)){
                    Text("Database Information")
                }
                .buttonStyle(GrowingButton())
                .padding(.bottom, 44)
            
        }.padding()
            .navigationTitle("Developer Options")
            .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let selection = navigationMenuService.detailRoutes.first(where: {$0.routableView == .emptyView}) {
                if (navigationSelectionService.detailSelection != selection){
                    navigationSelectionService.detailSelection = selection
                }
            }
        }
    }
}

#Preview {
    DeveloperView()
}
