//
//  SettingsViewController.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 1/07/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logOutButton: GeneralButton!
    @IBOutlet weak var backgroundView: GeneralView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userAgeLabel: UILabel!
    
    let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.backgroundColor = Constants.Colors.blueColor
        userNameLabel.text = viewModel.name
        userLastNameLabel.text = viewModel.lastName
        userEmailLabel.text = viewModel.email
        userAgeLabel.text = viewModel.age
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil,
                                                message: "Are you sure you want to log out",
                                                preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes, Sure",
                                style: .default) { (_) in
            self.showLoggedOutScreen()
        }
        alertController.addAction(yes)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoggedOutScreen() {
        self.tabBarController?.dismiss(animated: true, completion: {
            self.viewModel.logOut()
        })
        
    }
}
