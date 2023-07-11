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
    @State var viewModel: DatabaseInfoViewModel?
    
    var body: some View {
        List{
            if let vm = viewModel {
                Section("User Information"){
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.headline)
                        Text(vm.currentUsername)
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading) {
                        Text("Employee Departments")
                            .font(.headline)
                        Text(vm.userDepartments)
                            .font(.subheadline)
                    }
                }
                
                Section("Database File Information"){
                    VStack(alignment: .leading) {
                        Text("Database Path")
                            .font(.headline)
                        Text(vm.databasePath)
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading) {
                        Text("Database Name")
                            .font(.headline)
                        Text(vm.databaseName)
                            .font(.subheadline)
                    }
                }
                Section("Document Counts"){
                    VStack(alignment: .leading) {
                        Text("Employee Profiles")
                            .font(.headline)
                        Text("\(vm.employeeProfileCount)")
                            .font(.subheadline)
                    }
                }
                
                
                
            } else {
                Text("Error: Can't unwrap ViewModel")
            }
        }.navigationTitle("Database Information")
        .onAppear(perform: {
            viewModel = DatabaseInfoViewModel(
                databaseManager: databaseManager,
                employeeRepository: employeeRepository)
        })
    }
}

/*
 #Preview {
 let databaseManager = DatabaseManager()
 let viewModel = Binding<DatabaseInfoViewModel?>(databaseManager)
 DatabaseInfoView(viewModel: viewModel)
 .environmentObject(databaseManager)
 }
 */
