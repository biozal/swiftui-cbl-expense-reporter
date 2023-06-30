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
    
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var authenticationService: AuthenticationService
    @EnvironmentObject var userProfileRepository: UserProfileRepository

    var body: some View {
        VStack {
            Button(action: {
                    username = "craig.federighi@example.com"
                    password = "P@ssw0rd12"
            }){
                Image("CompanyLogo")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
            }.padding(.bottom, 40)
            
             
            
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
                    
                    //open database and load user profile into memory for later use
                    databaseManager.openDatabase()
                    userProfileRepository.loadUserProfile(userId: username)
                } else {
                    print("Authentication failed.")
                }
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color("CouchbaseRed"))
                    .cornerRadius(15)
            }
        }
        .padding()
    }
    
}

#Preview {
    AuthenticationView()
}
