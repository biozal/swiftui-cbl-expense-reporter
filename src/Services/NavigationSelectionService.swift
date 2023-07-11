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
    
    var contentSelection: NavigationMenuItem = NavigationMenuService.getDefault() {
        didSet{
            objectWillChange.send()
        }
    }
    
    var detailSelection: NavigationMenuItem? = nil {
        didSet{
            objectWillChange.send()
        }
    }
}
