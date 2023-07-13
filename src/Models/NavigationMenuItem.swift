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

class NavigationMenuItem
: Identifiable, Hashable, ObservableObject {

    
    var id: String
    
    let name: String
    let icon: Image
    let routableView: RoutableView
    
    init (id: String, name: String, icon: Image, routableView: RoutableView){
        self.id = id
        self.name = name
        self.icon = icon
        self.routableView = routableView
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: NavigationMenuItem, rhs: NavigationMenuItem) -> Bool {
        if (lhs.routableView == rhs.routableView)
        {
            return true
        }
        return false
    }
}
