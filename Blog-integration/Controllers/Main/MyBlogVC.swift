//
//  MyBlogVC.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit

class MyBlogVC: BasicVC {
    
    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = AuthorizationManager.shared.userProfile?.displayName
        emailLabel.text = AuthorizationManager.shared.userProfile?.email
    }
    
    // MARK: - Actions
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        AuthorizationManager.shared.logout()
    }

    @IBAction func newPostTapped(_ sender: UIButton) {
        
    }

}
