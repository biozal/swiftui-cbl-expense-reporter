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
        NavigationMenuItem(id: UUID().uuidString, name:"User Profile", icon: Image(systemName: "person.circle.fill")),
        NavigationMenuItem(id: UUID().uuidString, name: "Expense Reports", icon: Image(systemName: "coloncurrencysign.circle")),
        NavigationMenuItem(id: UUID().uuidString, name: "Developer", icon: Image(systemName: "gear")),
        NavigationMenuItem(id: UUID().uuidString, name: "Replication", icon: Image(systemName: "arrow.triangle.2.circlepath.circle.fill")),
    ]

}
