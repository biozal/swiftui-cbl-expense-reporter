//
//  UserProfileRepository.swift
//  ExpenseReporter
//

import Foundation
import Combine
import CouchbaseLiteSwift

class EmployeeRepository : ObservableObject {
    var databaseManager: DatabaseManager
    let _documentType = "employee"
    let blobKey = "employeProfileImage"
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var authenticatedEmployee: Employee? {
        didSet {
            objectWillChange.send()
        }
    }
    
    init (databaseManager: DatabaseManager){
        self.databaseManager = databaseManager
    }
    
    func loadUserProfile(userId: String) -> Void {
        guard let document = try? databaseManager.collection?.document(id: userId),
              let data = document.toJSON().data(using: .utf8),
              let userProfile = try? JSONDecoder().decode(Employee.self, from: data) else {
            authenticatedEmployee = Employee(email: userId)
            return
        }
        authenticatedEmployee = userProfile
    }
    
    func saveUserProfile(employeeDao: EmployeeDAO) -> Bool {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(employeeDao.employee)
            // Convert JSON data to a string
            guard let jsonString = String(data: jsonData, encoding: .utf8),
                  let userProfile = authenticatedEmployee else {
                return false
            }
            let mutableDoc = MutableDocument(id: userProfile.email)
            try mutableDoc.setJSON(jsonString)
            if let col = databaseManager.collection {
                if let image = employeeDao.imageData{
                    let blob = Blob(contentType: "image/png", data: image)
                    mutableDoc.setBlob(blob, forKey: blobKey)
                }
                try col.save(document: mutableDoc)
                return true
            }
            
        } catch { }
        
        return false
    }
}
