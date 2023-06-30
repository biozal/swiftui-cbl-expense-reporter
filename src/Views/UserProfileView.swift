//
//  UserProfileView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var _userProfileRepository: UserProfileRepository
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var jobTitle = ""
    @State private var selectedDepartments = Set<Department>()
    
    let departments = [
        Department(departmentName: "Accounting", departmentNumber: "1"),
        Department(departmentName: "Admin", departmentNumber: "2"),
        Department(departmentName: "Communicatoin", departmentNumber: "3"),
        Department(departmentName: "Engineering", departmentNumber: "4"),
        Department(departmentName: "Hardware Technologies", departmentNumber: "5"),
        Department(departmentName: "Information Technology", departmentNumber: "6"),
        Department(departmentName: "Marketing", departmentNumber: "7"),
        Department(departmentName: "Retail", departmentNumber: "8"),
        Department(departmentName: "Sales", departmentNumber: "9"),
        Department(departmentName: "Services", departmentNumber: "10"),
        Department(departmentName: "Support", departmentNumber: "11")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName )
                    TextField("Last Name", text: $lastName)
                    TextField("Job Title", text: $jobTitle)
                }
                //TODO maybe look at a cleaner implementation in a future release
                Section(header: Text("Department")) {
                    ForEach(departments, id: \.self) { department in
                        MultipleSelectionRow(title: department.departmentName, isSelected: self.selectedDepartments.contains(department)) {
                            if self.selectedDepartments.contains(department) {
                                self.selectedDepartments.remove(department)
                            } else {
                                self.selectedDepartments.insert(department)
                            }
                        }
                    }
                }
                
                Section() {
                    HStack{
                        Spacer()
                        Button(action: {
                            
                            _userProfileRepository.authenticatedUserProfile?.firstName = firstName
                            _userProfileRepository.authenticatedUserProfile?.lastName = lastName
                            _userProfileRepository.authenticatedUserProfile?.jobTitle = jobTitle
                            _userProfileRepository.authenticatedUserProfile?.department = selectedDepartments
                            let saveResults = _userProfileRepository.saveUserProfile()
                            if (saveResults){
                                //todo pop of navigation stack
                            } else {
                                //todo show error message
                            }
                            
                        }){
                            Text("Save")
                        }.buttonStyle(GrowingButton())
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("User Profile")
        }
        .onAppear{
            loadState()
        }
    }
    
    func loadState() {
        if let userProfile = _userProfileRepository.authenticatedUserProfile {
            firstName = userProfile.firstName
            lastName = userProfile.lastName
            jobTitle = userProfile.jobTitle
            if let departments = userProfile.department{
                selectedDepartments = departments
            }
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    UserProfileView()
}
