//
//  DatabaseInfoViewModel.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/11/23.
//

import Foundation
import SwiftUI

class DatabaseInfoViewModel : ObservableObject {
    var databaseManager: DatabaseManager
    var employeeRepository: EmployeeRepository
    
    @Published var databasePath: String = ""
    @Published var databaseName: String = ""
    @Published var currentUsername: String = ""
    @Published var userDepartments: String = ""
    
    @Published var reportCount:  Int = 0
    @Published var expenseCount: Int = 0
    @Published var managerCount: Int = 0
    @Published var employeeProfileCount: Int = 0
    @Published var expenseTypeCount: Int = 0
    
    //@Published var databaseInfo: [DatabaseInfo] = []
    init(
        databaseManager: DatabaseManager,
        employeeRepository: EmployeeRepository) {
            self.databaseManager = databaseManager
            self.employeeRepository = employeeRepository
            
            loadData()
        }
    
    func loadData() {
        currentUsername = employeeRepository.authenticatedEmployee?.employee.email ?? ""
        if let departments = employeeRepository .authenticatedEmployee?.employee.department
        {
            let departmentNames = departments.map { $0.name  }
            let joinedNames = departmentNames.joined(separator: ", ")
            
            userDepartments = joinedNames
        }
        
        databaseName = databaseManager.databaseName
        databasePath = databaseManager.database?.path ?? "Couldn't find database path"
        
        employeeProfileCount = employeeRepository.count()
    }
}
