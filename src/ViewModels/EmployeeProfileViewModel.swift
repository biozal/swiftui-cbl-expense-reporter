//
//  EmployeeProfileViewModel.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/13/23.
//

import Foundation
import SwiftUI

class EmployeeProfileViewModel : ObservableObject {
    var employeeRepository: EmployeeRepository?
    
    init() {
        
    }
    
    func loadState (employeeRepository: EmployeeRepository){
        self.employeeRepository = employeeRepository
    }
    
}
