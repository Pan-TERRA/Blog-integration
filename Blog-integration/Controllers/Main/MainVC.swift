//
//  MainVC.swift
//  Blog-integration
//
//  Created by Vlad Krut on 06.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit

class MainVC: BasicVC {
    
    // MARK: - Outlet

    @IBOutlet weak var container: UIView!
    
    // MARK: - Properties
    
    let myBlogVC = UINavigationController(rootViewController: MyBlogVC())
    let topUsersVC = UINavigationController(rootViewController: TopUsersVC())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        for vc in [myBlogVC, topUsersVC] {
            vc.setNavigationBarHidden(true, animated: false)
        }
        
        addChildViewController(topUsersVC)
        container.addSubview(topUsersVC.view)
        topUsersVC.view.frame = container.bounds
    }
    
    // MARK: - Actions
    
    @IBAction func myBlogTapped(_ sender: UIButton) {
        removeChilds()
        
        addChildViewController(myBlogVC)
        container.addSubview(myBlogVC.view)
        myBlogVC.view.frame = container.bounds
    }
    
    @IBAction func topUsersTapped(_ sender: UIButton) {
        removeChilds()
        
        addChildViewController(topUsersVC)
        container.addSubview(topUsersVC.view)
        topUsersVC.view.frame = container.bounds
    }

    private func removeChilds() {
        for child in childViewControllers {
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }
}
