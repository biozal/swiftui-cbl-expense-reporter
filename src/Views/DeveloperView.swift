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
    
    var body: some View {
        VStack{
            NavigationLink(destination:
                            DataLoaderView() .environmentObject(databaseManager)
                .environmentObject(employeeRepository)
            ){
                Text("Generate Sample Data")
            }
            .buttonStyle(GrowingButton())
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
    }
}

#Preview {
    DeveloperView()
}
