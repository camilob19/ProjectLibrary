//
//  SettingsViewModel.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 5/07/21.
//

import Foundation

class SettingsViewModel {
    
    let dataManager = CoreDataManager()
    let user = UserSession.shared.getCurrentUser()
    
    var name: String {
        return user.name
    }
    
    var lastName: String {
        return user.lastName
    }
    
    var email: String {
        return user.email
    }
    
    var age: String {
        return user.age
    }
    
    func logOut() {
        self.dataManager.deleteData("Favorites")
        self.dataManager.deleteData("Rentals")
        UserSession.shared.logOut()
    }
}
