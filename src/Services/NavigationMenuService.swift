//
//  NavigationService.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI
import Foundation


struct NavigationMenuService {
    let menuItems: [NavigationMenuItem] = [
        NavigationMenuItem(id: UUID().uuidString, name:"Employee Profile", icon: Image(systemName: "person.circle.fill"), routableView: RoutableView.employeeProfile),
        getDefault(),
        NavigationMenuItem(id: UUID().uuidString, name: "Developer", icon: Image(systemName: "gear"), routableView: RoutableView.developerList),
        NavigationMenuItem(id: UUID().uuidString, name: "Replication", icon: Image(systemName: "arrow.triangle.2.circlepath.circle.fill"),routableView: RoutableView.replicationStatus),
    ]
    
    static func getDefault() -> NavigationMenuItem {
        return NavigationMenuItem(id: UUID().uuidString, name: "Expense Reports", icon: Image(systemName: "coloncurrencysign.circle"), routableView: RoutableView.reports)
    }

}
