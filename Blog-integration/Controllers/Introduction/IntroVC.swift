//
//  IntroVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 22.11.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class IntroVC: BasicVC {
    
    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        printCurrentTag()
    }
    
    // MARK: - Actions
    
    @IBAction func nextTapped(_ sender: UIButton) {
        let login = LoginVC()
        
        navigationController?.pushViewController(login, animated: true)
    }
}
