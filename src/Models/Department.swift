//
//  Department.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/29/23.
//

import Foundation

struct Department : Codable,Hashable {
    var departmentName  : String = ""
    var departmentNumber: String = ""
    
    init (departmentName: String, departmentNumber: String) {
        self.departmentName = departmentName
        self.departmentNumber =  departmentNumber
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(departmentNumber)
    }
}
