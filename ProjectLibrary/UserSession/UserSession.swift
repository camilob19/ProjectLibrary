//
//  UserSession.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 3/07/21.
//

import Foundation

struct User {
    var name: String
    var lastName: String
    var email: String
    var age: String
}

class UserSession {
    static let shared: UserSession = UserSession()
    let key = "isUserLoggedIn"
    let nameKey = "userName"
    let lastNameKey = "lastName"
    let emailKey = "email"
    let ageKey = "age"
    
    let defaults = UserDefaults.standard
    func login(with user: User) {
        defaults.set(true, forKey: key)
        defaults.set(user.name, forKey: nameKey)
        defaults.set(user.lastName, forKey: lastNameKey)
        defaults.set(user.email, forKey: emailKey)
        defaults.set(user.age, forKey: ageKey)
    }
    
    func logOut() {
        defaults.removeObject(forKey: key)
        defaults.removeObject(forKey: nameKey)
        defaults.removeObject(forKey: lastNameKey)
        defaults.removeObject(forKey: emailKey)
        defaults.removeObject(forKey: ageKey)
    }
    
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: key)
    }
    
    func getCurrentUser() -> User {
        return User(name: defaults.string(forKey: nameKey) ?? "",
                    lastName: defaults.string(forKey: lastNameKey) ?? "",
                    email: defaults.string(forKey: emailKey) ?? "",
                    age: defaults.string(forKey: ageKey) ?? "")
    }
}
