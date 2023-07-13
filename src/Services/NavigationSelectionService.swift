//
//  NavigationSelectionService.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/30/23.
//

import Foundation
import Combine
import SwiftUI

class NavigationSelectionService : ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var detailSelection: NavigationMenuItem? = nil {
        didSet{
            objectWillChange.send()
        }
    }
}
