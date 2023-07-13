//
//  NavigationSelectionService.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/30/23.
//

import Foundation
import SwiftUI

class NavigationSelectionService : ObservableObject {
    @Published var detailSelection: NavigationMenuItem?
}
