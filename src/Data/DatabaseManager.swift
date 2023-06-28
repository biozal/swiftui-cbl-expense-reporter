//
//  DatabaseManager.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import Foundation
import CouchbaseLiteSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    let database: Database?
    let collection: Collection?
    let scope: Scope?
    
    private init() {
        database = try! Database(name: "expensereports")
        scope = try! database?.scope(name: "_default")
        collection = try! scope?.collection(name: "_default")
    }
    
    deinit {
        do {
            try self.database?.close()
        } catch{
            //TODO logging
        }
    }
    
}

