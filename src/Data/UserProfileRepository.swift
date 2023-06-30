//
//  UserProfileRepository.swift
//  ExpenseReporter
//

import Foundation
import Combine
import CouchbaseLiteSwift

class UserProfileRepository : ObservableObject {
    var databaseManager: DatabaseManager
    let _documentType = "userprofile"
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var authenticatedUserProfile: UserProfile? {
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
              let userProfile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            authenticatedUserProfile = UserProfile(email: userId)
            return
        }
        authenticatedUserProfile = userProfile
    }
    
    func saveUserProfile() -> Bool {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(authenticatedUserProfile)
            // Convert JSON data to a string
            guard let jsonString = String(data: jsonData, encoding: .utf8),
                    let userProfile = authenticatedUserProfile else {
                return false
            }
                let mutableDoc = MutableDocument(id: userProfile.email)
                try mutableDoc.setJSON(jsonString)
                if let col = databaseManager.collection {
                    try col.save(document: mutableDoc)
                    return true
                }
   
        } catch { }

        return false
    }
}
