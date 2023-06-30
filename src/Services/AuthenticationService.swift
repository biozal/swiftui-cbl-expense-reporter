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
        let users = getUsers()
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            isAuthenticated = true
            self.username = username
            return true
        } else {
            isAuthenticated = false
            return false
        }
    }
    
    func getUsers () -> [User]{
        return [
            User(username:"jane.doe@example.com", password: "P@ssw0rd12"),
            User(username:"john.smith@example.com", password: "P@ssw0rd12"),
            User(username:"steve.jobs@example.com", password: "P@ssw0rd12"),
            User(username:"steve.woz@example.com", password: "P@ssw0rd12"),
            User(username:"gemma.watson@example.com", password: "P@ssw0rd12"),
            User(username:"craig.federighi@example.com", password: "P@ssw0rd12"),
            User(username:"mike.fenger@example.com", password: "P@ssw0rd12")
        ]
    }
}

struct User {
    var username: String
    var password: String
}
