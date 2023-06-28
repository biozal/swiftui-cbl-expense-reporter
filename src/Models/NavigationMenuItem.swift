//
//  NavigationMenuItem.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI
import Foundation

struct NavigationMenuItem: Identifiable, Hashable {
    var id: String
    
    let name: String
    let icon: Image
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(name)
    }
}
