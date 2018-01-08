//
//  MyBlogVC.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class MyBlogVC: MappableTableVC {
    
    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = AuthorizationManager.shared.userProfile?.displayName
        emailLabel.text = AuthorizationManager.shared.userProfile?.email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataFromServer(completionHandler: nil)
    }
    
    // MARK: - Data
    
    override func loadDataFromServer(completionHandler: ((Error?) -> ())?) {
        
        mappables.removeAll()
        
        APIManager().getMyPosts(success: { [weak self] response in
            
            guard let items = response as? [String: Any] else { return }
            
            let mapper = Mapper<PostModel>()
            
            for entry in items {
                guard let jsonPost = entry.value as? [String: Any] else { continue }
                
                if let post = mapper.map(JSON: jsonPost) {
                    self?.mappables.append(post)
                }
                
            }
            
            if completionHandler != nil {
                completionHandler!(nil)
            } else {
                self?.tableView.reloadData()
            }
            
        }, failure: { [weak self] error in
            print(error.localizedDescription)
            completionHandler?(error)
        })
    }

    
    // MARK: - Actions
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        AuthorizationManager.shared.logout()
    }

    @IBAction func newPostTapped(_ sender: UIButton) {
        navigationController?.pushViewController(NewPostVC(), animated: true)
    }

}


extension MyBlogVC: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "You don't have any posts yet")
    }
}
