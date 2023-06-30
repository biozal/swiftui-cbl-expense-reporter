//
//  GrowingButton.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.leading, 80)
            .padding(.trailing, 80)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .background(Color("CouchbaseRed"))
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    GrowingButton() as! any View
}
