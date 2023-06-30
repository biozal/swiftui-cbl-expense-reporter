//
//  UserProfile.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/29/23.
//

import Foundation

struct UserProfile : Codable {
    var firstName: String
    var lastName: String
    var email: String
    var jobTitle: String
    var modifiedDate: Date
    var department: Set<Department>?
    var documnentType = "userProfile"
    
    init(firstName: String, lastName: String, email: String, jobTitle: String, department: Set<Department>?, modifiedDate: Date)  {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.jobTitle = jobTitle
        self.department = department
        self.modifiedDate = modifiedDate
    }
    
    //TODO maybe convert to factory or use static function to prebuild on
    init(email: String) {
        self.firstName = ""
        self.lastName = ""
        self.email = email
        self.jobTitle = ""
        self.department = []
        self.modifiedDate = Date()
    }
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.jobTitle = ""
        self.department = []
        self.modifiedDate = Date()
    }
    
    func fullName() -> String {
        if !firstName.isEmpty {
            return firstName + " " + lastName
        } else{
            return "No Name Set"
        }
    }
}
