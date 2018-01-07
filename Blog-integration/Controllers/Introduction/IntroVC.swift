//
//  IntroVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 22.11.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class IntroVC: BasicVC {
    
    // MARK: - Outlets
    
    @IBOutlet weak var gitDescribe: UILabel! {
        didSet {
            gitDescribe.text = getGitTag()
        }
    }
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        printCurrentTag()
    }
    
    // MARK: - Actions
    
    @IBAction func nextTapped(_ sender: UIButton) {
        
        AuthorizationManager.shared.login(on: self)
    }
}
