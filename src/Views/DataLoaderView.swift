//
//  DataLoaderView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/6/23.
//

import SwiftUI

struct DataLoaderView: View {
    @EnvironmentObject var databaseManager: DatabaseManager

    var body: some View {
        Text("Data Loader View")
    }
}

#Preview {
    DataLoaderView()
}
