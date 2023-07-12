//
//  AuthenticationView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/25/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State private var viewModel: AuthenticationViewModel
    
    @EnvironmentObject var databaseManager: DatabaseManager
    @EnvironmentObject var authenticationService: AuthenticationService
    @EnvironmentObject var employeeRepository: EmployeeRepository
    
    init () {
        viewModel = AuthenticationViewModel()
    }
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.autoFillUsernamePassword()
            }){
                Image("CompanyLogo")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
            }.padding(.bottom, 40)
            
            
            
            TextField("Username", text: $viewModel.username)
                .padding()
                .autocapitalization(.none)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 10)
                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.8)
            
            ZStack(alignment: .trailing) {
                if viewModel.isPasswordVisible {
                    TextField("Password", text: $viewModel.password)
                } else {
                    SecureField("Password", text: $viewModel.password)
                }
                
                Button(action: {
                    viewModel.isPasswordVisible.toggle()
                }) {
                    Image(systemName: viewModel.isPasswordVisible ? "eye.slash.fill" : "eye.fill")
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
                viewModel.processUserAuthentication()
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
        .onAppear(){
            viewModel.loadState(databaseManager: databaseManager, authenticationService: authenticationService,
                employeeRepository: employeeRepository)
        }
    }
    
}

#Preview {
    AuthenticationView()
}
