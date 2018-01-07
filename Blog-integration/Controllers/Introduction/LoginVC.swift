//
//  LoginVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class LoginVC: BasicVC {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailFIeld: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Actions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = emailFIeld.text, !email.isEmpty else {
            showInfoLabelWithText("Email field cannot be empty", controller: self)
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            showInfoLabelWithText("Password field cannot be empty", controller: self)
            return
        }
        
        startLoading()
        
        AuthorizationManager.shared.loginManually(email: email, password: password, completionHandler: { error in
            
            self.stopLoading()
            
            if error == nil {
                
                let vc = MainVC()
                
                let navigationVC = UINavigationController(rootViewController: vc)
                navigationVC.setNavigationBarHidden(true, animated: false)
                
                UIApplication.shared.keyWindow?.set(toRootViewController: navigationVC)
                
            } else {
                if let statusCode = error!.statusCode, statusCode == 401 {
                    self.showAlertWith(text: "Wrong login or password", controller: self)
                } else {
                    self.showAlertWith(text: "Something went wrong", controller: self)
                }
            }
        })
        
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    
    @IBAction func testData(_ sender: UILongPressGestureRecognizer) {
        emailFIeld.text = "test@sponsorhuset.se"
        passwordField.text = "test123"
    }

}
