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
    //fileprivate var _applicationDocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    var applicationDocumentDirectory = URL.documentsDirectory.path()
    
    //prebuilt database that is embedded in the app
    fileprivate var _applicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
    
    var databaseName = "expensereports"
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
        
        var options = DatabaseConfiguration()
        options.directory = applicationDocumentDirectory
        
        database = try! Database(name: databaseName, config: options)
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

