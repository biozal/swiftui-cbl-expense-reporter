//
//  ContentView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI

struct ReportsView: View {
    
    @EnvironmentObject var navigationSelectionService: NavigationSelectionService
    
    @EnvironmentObject var navigationMenuService: NavigationMenuService
   
    var body: some View {
        VStack{
            Text("Expense Reports")
        }.navigationTitle("Expense Reports")
         .navigationBarTitleDisplayMode(.inline)
         .onAppear {
             if let selection = navigationMenuService.detailRoutes.first(where: {$0.routableView == .expenseReport}) {
                 if (navigationSelectionService.detailSelection != selection){
                     navigationSelectionService.detailSelection = selection
                 }
             }
         }
    }
}

#Preview {
    ReportsView()
}
