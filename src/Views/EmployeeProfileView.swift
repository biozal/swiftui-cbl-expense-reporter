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
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var avatarData: Data?
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var jobTitle = ""
    @State private var selectedDepartments = Set<Department>()
    
    @ObservedObject var viewModel: EmployeeProfileViewModel = EmployeeProfileViewModel()
    
    let departments = [
        Department(name: "Accounting", deptNumber: "1"),
        Department(name: "Admin", deptNumber: "2"),
        Department(name: "Communicatoin", deptNumber: "3"),
        Department(name: "Engineering", deptNumber: "4"),
        Department(name: "Hardware Technologies", deptNumber: "5"),
        Department(name: "Information Technology", deptNumber: "6"),
        Department(name: "Marketing", deptNumber: "7"),
        Department(name: "Retail", deptNumber: "8"),
        Department(name: "Sales", deptNumber: "9"),
        Department(name: "Services", deptNumber: "10"),
        Department(name: "Support", deptNumber: "11")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                VStack{
                    PhotosPicker("Select Profile Picture", selection: $avatarItem, matching: .images)
                        .photosPickerStyle(.presentation)
                    
                    if let avatarImage {
                        avatarImage
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                        
                    }
                }
                .onChange(of: avatarItem, initial: false) {
                           Task {
                              
                               if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                                   //todo - maybe make this more efficient
                                   if let uiImage = UIImage(data: data) {
                                       //resize the image to make it smaller
                                       if let newImage = uiImage.scale(to: CGSize(width: 300, height: 300)){
                                           avatarData = newImage.pngData()
                                           
                                           avatarImage =
                                                Image(uiImage: newImage)
                                       }
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
                        MultipleSelectionRow(title: department.name, isSelected: self.selectedDepartments.contains(department)) {
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
                            if var employee = employeeRepository.authenticatedEmployee?.employee {
                                employee.firstName = firstName
                                employee.lastName = lastName
                                employee.jobTitle = jobTitle
                                employee.department = Array(selectedDepartments)
                                
                                //wrap employee and image to send to repository
                                var employeeDao = EmployeeDAO(employee: employee, imageData: nil)
                                
                                if let data = avatarData {
                                    employeeDao.imageData = data
                                }
                                let saveResults = employeeRepository.saveEmployeeProfile(employeeDao: employeeDao)
                                
                                if (saveResults){
                                    //route back to expense reports
                                    //pop view off
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
        
        viewModel.loadState(employeeRepository: employeeRepository)
        
        if let employeeProfile = employeeRepository.authenticatedEmployee?.employee {
            firstName = employeeProfile.firstName
            lastName = employeeProfile.lastName
            jobTitle = employeeProfile.jobTitle
            if let departments = employeeProfile.department{
                selectedDepartments = Set(departments)
            }
            if let data = employeeRepository.authenticatedEmployee?.imageData {
                avatarData = data
                if let uiImage = UIImage(data: data){
                    avatarImage = Image(uiImage: uiImage)
                }
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
