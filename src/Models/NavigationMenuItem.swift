//
//  NavigationMenuItem.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI
import Foundation

enum RoutableView {
    case employeeProfile
    case reports
    case reportEditor
    case expenseReport
    case developerList
    case replicationStatus
    case databaseInformation
    case dataGenerator
    case logViewer
    case emptyView
}

struct NavigationMenuItem: Identifiable, Hashable {
    var id: String
    
    let name: String
    let icon: Image
    let routableView: RoutableView
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(name)
    }
}
