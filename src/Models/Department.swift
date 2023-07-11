//
//  Department.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/29/23.
//

import Foundation

struct Department : Codable,Hashable {
    var name  : String = ""
    var deptNumber: String = ""
    
    init (name: String, deptNumber: String) {
        self.name = name
        self.deptNumber =  deptNumber
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(deptNumber)
    }
}
