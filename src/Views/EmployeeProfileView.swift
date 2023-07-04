//
//  UserProfileView.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 6/27/23.
//

import SwiftUI
import PhotosUI
struct EmployeeProfileView: View {
    
    @EnvironmentObject var employeeRepository: EmployeeRepository
    @Binding var selectedNavigationMenuItem: NavigationMenuItem?
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var avatarData: Data?
    
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
                VStack{
                    PhotosPicker("Select Profile Picture", selection: $avatarItem, matching: .images).photosPickerStyle(.presentation)
                    
                    if let avatarImage {
                        avatarImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                    }
                }
                .onChange(of: avatarItem, initial: false) {
                           Task {
                               if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                                   avatarData = data
                                   if let uiImage = UIImage(data: data) {
                                       avatarImage = Image(uiImage: uiImage)
                                       return
                                   }
                               }

                               print("Failed")
                           }
                       }
                .frame(maxWidth: .infinity, alignment: .center)
                
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
                            if var employee = employeeRepository.authenticatedEmployee {
                                employee.firstName = firstName
                                employee.lastName = lastName
                                employee.jobTitle = jobTitle
                                employee.department = selectedDepartments
                                
                                //wrap employee and image to send to repository
                                var employeeDao = EmployeeDAO(employee: employee, imageData: nil)
                                
                                if let data = avatarData {
                                    employeeDao.imageData = data
                                }
                                let saveResults = employeeRepository.saveUserProfile(employeeDao: employeeDao)
                                
                                if (saveResults){
                                    //route back to expense reports
                                    selectedNavigationMenuItem = NavigationMenuService.getDefault()
                                    
                                } else {
                                    //todo show error message
                                }
                            }
                            
                        }){
                            Text("Save")
                        }.buttonStyle(GrowingButton())
                        Spacer()
                    }
                }
            }
        }
        .onAppear{
            loadState()
        }
    }
    
    func loadState() {
        if let employeeProfile = employeeRepository.authenticatedEmployee {
            firstName = employeeProfile.firstName
            lastName = employeeProfile.lastName
            jobTitle = employeeProfile.jobTitle
            if let departments = employeeProfile.department{
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
/*
 #Preview {
 @State var isActive = false
 
 EmployeeProfileView(navigationLinkIsActive: $isActive)
 }
 */
