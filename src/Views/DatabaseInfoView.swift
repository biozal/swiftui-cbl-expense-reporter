//
//  DatabaseInfoView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/6/23.
//

import SwiftUI

struct DatabaseInfoView: View {
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var employeeRepository: EmployeeRepository
    
    @ObservedObject var viewModel: DatabaseInfoViewModel = DatabaseInfoViewModel()
    
    var body: some View {
        List{
            Section("User Information"){
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.headline)
                    Text(viewModel.currentUsername)
                        .font(.subheadline)
                }
                VStack(alignment: .leading) {
                    Text("Employee Departments")
                        .font(.headline)
                    Text(viewModel.userDepartments)
                        .font(.subheadline)
                }
            }
            
            Section("Database File Information"){
                VStack(alignment: .leading) {
                    Text("Database Path")
                        .font(.headline)
                    Text(viewModel.databasePath)
                        .font(.subheadline)
                }
                VStack(alignment: .leading) {
                    Text("Database Name")
                        .font(.headline)
                    Text(viewModel.databaseName)
                        .font(.subheadline)
                }
            }
            Section("Document Counts"){
                VStack(alignment: .leading) {
                    Text("Employee Profiles")
                        .font(.headline)
                    Text("\(viewModel.employeeProfileCount)")
                        .font(.subheadline)
                }
            }
                
        }.navigationTitle("Database Information")
            .onAppear(perform: {
                viewModel.loadState(
                    databaseManager: databaseManager,
                    employeeRepository: employeeRepository)
            })
    }
}

 #Preview {
 DatabaseInfoView(viewModel: DatabaseInfoViewModel())
 }
