//
//  Manager.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import Foundation

import Foundation

struct ManagerDao: Codable {
    var item: Manager
}

struct Manager: Codable {
    let managerId: String
    let givenName: String
    let surname: String
    let email: String
    let jobTitle: String
    let department: [Department]?
    let documentType: String

    init(managerId: String = "",
         givenName: String = "",
         surname: String = "",
         email: String = "",
         jobTitle: String = "",
         department: [Department]? = nil,
         documentType: String = "manager") {

        self.managerId = managerId
        self.givenName = givenName
        self.surname = surname
        self.email = email
        self.jobTitle = jobTitle
        self.department = department
        self.documentType = documentType
    }
}
