//
//  NavigationService.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI
import Foundation


class NavigationMenuService : ObservableObject {
    
    let menuItems: [NavigationMenuItem] = [
        NavigationMenuItem(id: UUID().uuidString, name:"Employee Profile", icon: Image(systemName: "person.circle.fill"), routableView: RoutableView.employeeProfile),
        getDefault(),
        NavigationMenuItem(id: UUID().uuidString, name: "Developer", icon: Image(systemName: "gear"), routableView: RoutableView.developerList),
        NavigationMenuItem(id: UUID().uuidString, name: "Replication", icon: Image(systemName: "arrow.triangle.2.circlepath.circle.fill"),routableView: RoutableView.replicationStatus),
    ]
    
    let detailRoutes: [NavigationMenuItem] = [
        NavigationMenuItem(id: UUID().uuidString, name:"Database Information", icon: Image(systemName: "info.square"), routableView: RoutableView.databaseInformation),
        NavigationMenuItem(id: UUID().uuidString, name:"Data Generator ", icon: Image(systemName: "arrow.up.left.arrow.down.right.square.fill"), routableView: RoutableView.dataGenerator),
        NavigationMenuItem(id: UUID().uuidString, name:"Expense Report Detail", icon: Image(systemName: "coloncurrencysign.square.fill"), routableView: RoutableView.expenseReport),
    ]
    
    static func getDefault() -> NavigationMenuItem {
        return NavigationMenuItem(id: UUID().uuidString, name: "Expense Reports", icon: Image(systemName: "coloncurrencysign.circle"), routableView: RoutableView.reports)
    }

}
