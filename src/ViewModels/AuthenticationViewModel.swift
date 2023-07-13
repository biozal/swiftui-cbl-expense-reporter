//
//  AuthenticationViewModel.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/11/23.
//

import Foundation
import SwiftUI

class AuthenticationViewModel : ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    
    var databaseManager: DatabaseManager?
    var authenticationService: AuthenticationService?
    var employeeRepository: EmployeeRepository?
    
    init () {
    }
    
    //
    //used to save typing - do not ship this in production
    //
    func autoFillUsernamePassword () {
        self.username = "craig.federighi@example.com"
        self.password = "P@ssw0rd12"
    }
    
    func loadState (databaseManager: DatabaseManager,
                    authenticationService: AuthenticationService,
                    employeeRepository: EmployeeRepository)
    {
        self.databaseManager = databaseManager
        self.authenticationService = authenticationService
        self.employeeRepository = employeeRepository
    }
    
    func processUserAuthentication() {
        if let authService = authenticationService,
           let dbManager = databaseManager,
           let emplRepository = employeeRepository {
            
            let authenticated = authService.authenticate(username: username, password: password)
            if authenticated {
                //open database and load user profile into memory for later use
                dbManager.openDatabase(userId: username)
                emplRepository.loadEmployeeProfile(userId: username)
            } else {
                print("Authentication failed.")
            }
        }
    }
    
}
