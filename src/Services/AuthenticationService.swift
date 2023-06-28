import Foundation
import Combine

class AuthenticationService : ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var isAuthenticated = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    var username = "" {
        didSet{
            objectWillChange.send()
        }
    }
    
    func authenticate(username: String, password: String) -> Bool {
        let correctUsername = "user@example.com"
        let correctPassword = "P@ssw0rd12"
        
        if username == correctUsername && password == correctPassword {
            isAuthenticated = true
            self.username = username
            return true
        } else {
            isAuthenticated = false
            return false
        }
    }
}
