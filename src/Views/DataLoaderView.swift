//
//  DataLoaderView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/6/23.
//

import SwiftUI

struct DataLoaderView: View {
    
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var employeeRepository : EmployeeRepository
    @EnvironmentObject var expenseReportRepository: ReportsRepository
    
    @ObservedObject var viewModel: DataLoaderViewModel = DataLoaderViewModel()

    var body: some View {
        VStack(alignment: .center){
            Button(action: {
                viewModel.generateData()
            }){
                HStack{
                    Image(systemName: "arrow.right.square")
                    Text("Generate Data")
                }
            }
            .buttonStyle(GrowingButton())
                .padding(.bottom, 40)
                .padding(.top, 20)
            
            Text(viewModel.logInfo)
        }
        .navigationTitle("Data Loader")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            self.viewModel.loadState(
                databaseManager: databaseManager,
                employeeRepository: employeeRepository,
                expenseReportRepository: expenseReportRepository)
        }
    }
}

#Preview {
    DataLoaderView()
}
