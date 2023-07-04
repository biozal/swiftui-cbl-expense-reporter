//
//  NavigationSelectionService.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/30/23.
//

import Foundation
import Combine

class NavigationSelectionService : ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var selection: NavigationMenuItem = NavigationMenuService.getDefault() {
        didSet{
            objectWillChange.send()
        }
    }
}
