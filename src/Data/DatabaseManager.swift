//
//  DatabaseManager.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import Foundation
import CouchbaseLiteSwift

class DatabaseManager: ObservableObject {
    
    var database: Database?
    var collection: Collection?
    var scope: Scope?
   
    //local database for storage
    fileprivate var _applicationDocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    
    //prebuilt database that is embedded in the app
    fileprivate var _applicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
    
    init() {
        Database.log.console.domains = .all
        
        //this will log EVERYTHING - it's a lot of information to go through
        Database.log.console.level = .verbose
    }
    
    deinit {
        do {
            try self.database?.close()
        } catch{
            //TODO logging
        }
    }
    
    func openDatabase() {
        
        if let path = _applicationDocumentDirectory?.path() {
            var options = DatabaseConfiguration()
            options.directory = path
            database = try! Database(name: "expensereports", config: options)
        } else {
            database = try! Database(name: "expensereports")
        }
        scope = try! database?.scope(name: "_default")
        collection = try! scope?.collection(name: "_default")
    }
    
    func closeDatabase() {
        do {
            try self.database?.close()
        } catch{
            //TODO logging
        }
    }
    
}

