//
//  RegisterVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 23.11.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class RegisterVC: BasicVC {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Setup

    
    // MARK: - Actions
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        guard let nick = nickNameField.text, !nick.isEmpty else {
            showInfoLabelWithText("Nickname field cannot be empty", controller: self)
            return
        }
        
        guard let email = emailField.text, !email.isEmpty else {
            showInfoLabelWithText("Email field cannot be empty", controller: self)
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            showInfoLabelWithText("Password field cannot be empty", controller: self)
            return
        }
        
        let form = RegistrationForm()

        form.nickname = nick
        form.email = email
        form.password = password
        
        register(form: form)
    }
    
    // MARK: - Data
    
    func register(form: RegistrationForm) {
        
        return
        
        startLoading()
        APIManager().registerUser(data: form, success: { [weak self] response in
            
            print(response)
            
            self?.stopLoading()
            AuthorizationManager.shared.saveCurrentUserProfile(response: response)
            
        }, failure: { [weak self] error in
            self?.stopLoading()
            
            if error.readableData == "user_exists" {
                self?.showAlertWith(text: "This user already exists", controller: self)
            } else {
                self?.showAlertWith(text: "Something went wrong", controller: self)
            }
            
            print(error)
        })
    }

}
