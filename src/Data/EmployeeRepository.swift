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
    
    var authenticatedEmployee: EmployeeDAO? {
        didSet {
            objectWillChange.send()
        }
    }
    
    init (databaseManager: DatabaseManager){
        self.databaseManager = databaseManager
    }
    
    func loadEmployeeProfile(userId: String) -> Void {
        guard let document = try? databaseManager.collection?.document(id: userId),
              let data = document.toJSON().data(using: .utf8),
              let userProfile = try? JSONDecoder().decode(Employee.self, from: data) else {
            authenticatedEmployee = EmployeeDAO(employee: Employee(email: userId))
            return
        }
        if document.contains(key: blobKey) {
                if let blob = document.blob(forKey: blobKey) {
                        if let data = blob.content{
                            authenticatedEmployee = EmployeeDAO(employee: userProfile, imageData: data)
                        }
                    }
                }
        else {
            authenticatedEmployee = EmployeeDAO(employee: userProfile)
        }
    }
    
    func saveEmployeeProfile(employeeDao: EmployeeDAO) -> Bool {
        //todo - nuke existing image from the profile so we don't have
        //old images laying around wasting space.
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(employeeDao.employee)
            // Convert JSON data to a string
            guard let jsonString = String(data: jsonData, encoding: .utf8),
                  let userProfileDao = authenticatedEmployee else {
                return false
            }
            let mutableDoc = MutableDocument(id: userProfileDao.employee.email)
            try mutableDoc.setJSON(jsonString)
            if let col = databaseManager.collection {
                //todo delete existing image if there is one
                if let image = employeeDao.imageData{
                    let blob = Blob(contentType: "image/png", data: image)
                    mutableDoc.setBlob(blob, forKey: blobKey)
                }
                try col.save(document: mutableDoc)
                authenticatedEmployee = employeeDao
                return true
            }
            
        } catch { }
        
        return false
    }
   
    func count() -> Int {
        var count = 0
        do {
            if let database = databaseManager.database {
                let query = try database.createQuery("SELECT COUNT(*) AS count FROM _ AS item WHERE documentType=\"userProfile\"")
                let results: [Result] = try query.execute().allResults()
                count = results[0].int(forKey: "count")
            }
            
        } catch { }
        
        return count
    }
    
}
