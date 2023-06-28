//
//  UserProfileRepository.swift
//  ExpenseReporter
//

import Foundation

class UserProfileRepository {
    let _documentType = "userprofile"
    let _collection = DatabaseManager.shared.collection
    
    func get(userId: String) -> [String: Any] {
        let data: [String: Any] = ["id": userId]
        guard let document = try! _collection?.document(id: userId) else {
            return data
        }
        return document.toDictionary()
    }
}
