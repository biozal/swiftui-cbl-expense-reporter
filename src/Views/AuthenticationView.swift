//
//  AuthenticationView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/25/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @EnvironmentObject var authenticationService: AuthenticationService

    var body: some View {
        VStack {
            Text("Acme Expense Reporter")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            TextField("Username", text: $username)
                .padding()
                .autocapitalization(.none)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 10)
                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.8)
            
            ZStack(alignment: .trailing) {
                   if isPasswordVisible {
                       TextField("Password", text: $password)
                   } else {
                       SecureField("Password", text: $password)
                   }
                   
                   Button(action: {
                       isPasswordVisible.toggle()
                   }) {
                       Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                           .foregroundColor(.gray)
                   }
                   .padding(.trailing)
               }
               .padding()
               .background(Color(.systemGray6))
               .cornerRadius(10)
               .frame(maxWidth: UIScreen.main.bounds.size.width * 0.8)
               .padding(.bottom, 10)
            
            Button(action: {
                let authenticated = authenticationService.authenticate(username: username, password: password)
                if authenticated {
                    print("Authentication successful!")
                } else {
                    print("Authentication failed.")
                }
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
        }
        .padding()
    }
    
}

#Preview {
    AuthenticationView()
}
