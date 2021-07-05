//
//  LoginViewController.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 28/06/21.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var navegationBarImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var backgroundView: GeneralView!
    @IBOutlet weak var lastNameTextField: GeneralTextfield!
    @IBOutlet weak var nameTextField: GeneralTextfield!
    @IBOutlet weak var emailTextField: GeneralTextfield!
    @IBOutlet weak var signInButton: GeneralButton!
    @IBOutlet weak var ageTextField: GeneralTextfield!
    @IBOutlet weak var acceptPoliticalButton: UIButton!
    @IBOutlet weak var acceptTermsButton: UIButton!
    @IBOutlet weak var formStack: UIStackView!
    @IBOutlet weak var stackTopConstraint: NSLayoutConstraint!
    
    var isOn: Bool = false
    var isOntwo: Bool = false
    let imageAcceptOn = UIImage(named: "ic_myrentals active")
    let imageAcceptOff = UIImage(named: "ic_myrentals")
    
    var ageArray: [String] = []
    var pickerView = UIPickerView()
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        fillAges()
        pickerView.delegate = self
        pickerView.dataSource = self
        ageTextField.inputView = pickerView
        self.formStack.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.formStack.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserSession.shared.isLoggedIn() {
            loadHome()
        }
    }
    
    func configUI () {
        ageTextField.layer.cornerRadius = 16
        signInButton.backgroundColor = Constants.Colors.blueColor
    }
    
    func fillAges() {
        for item in 8...100 {
            ageArray.append("\(item)")
        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        SVProgressHUD.show()
        let areNamesValid = viewModel.isValidName(textName: nameTextField.text ?? "") &&
            viewModel.isValidName(textName: lastNameTextField.text ?? "")
        if !areNamesValid {
            showError(msg: "Please enter personal data")
        }
        
        let isValidName = viewModel.isValidEmail(emailTextField.text ?? "")
        if !isValidName {
            showError(msg: "Please enter your  email address")
        }
        
        if !isOn {
            showError(msg: "Please accept political and treatment data")
            
        }
        
        if !isOntwo {
            showError(msg: "Please accept terms and conditions")
        }
        
        if let age = ageTextField.text, age.isEmpty {
            showError(msg: "Please select your age")
        }
        SVProgressHUD.dismiss()
        setUser()
        loadHome()
    }
    
    private func setUser() {
        let user = User(name: nameTextField.text ?? "",
                        lastName: lastNameTextField.text ?? "",
                        email: emailTextField.text ?? "",
                        age: ageTextField.text ?? "")
        UserSession.shared.login(with: user)
    }
    
    func showError(msg: String) {
        
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
    func loadHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")
        present(viewController, animated: true, completion: nil)
    }
 
    @IBAction func acceptDataButton(_ sender: Any) {
        isOn.toggle()
        setBackButton(view: acceptPoliticalButton,
                      imageOn: imageAcceptOn,
                      imageOff: imageAcceptOff, onOffStatus: isOn)
    }
    
    @IBAction func acceptTermsButton(_ sender: Any) {
        isOntwo.toggle()
        setBackButton(view: acceptTermsButton,
                      imageOn: imageAcceptOn,
                      imageOff: imageAcceptOff, onOffStatus: isOntwo)
    }
    
    func setBackButton(view: UIButton, imageOn: UIImage?, imageOff: UIImage?, onOffStatus: Bool) {
        onOffStatus ? view.setImage(imageOn, for: .normal) : view.setImage(imageOff, for: .normal)
    }
}

extension LoginViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageArray[row]
    }
}

extension LoginViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageTextField.text = ageArray[row]
        ageTextField.resignFirstResponder()
    }
}
