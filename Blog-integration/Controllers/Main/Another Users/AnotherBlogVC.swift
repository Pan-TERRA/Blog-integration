//
//  AnotherBlogVC.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class AnotherBlogVC: MappableTableVC {
    
    // MARK: - Constants
    
    // MARK: - Properties
    
    var user: ProfileModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = user?.nickname
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataFromServer(completionHandler: nil)
    }
    
    // MARK: - Data
    
    override func loadDataFromServer(completionHandler: ((Error?) -> ())?) {
        
        guard let userID = user?.uid else { return }
        
        mappables.removeAll()
        
        APIManager().getPostsBy(userID: userID, success: { [weak self] response in
            
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
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension AnotherBlogVC: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "This user doesn't have any posts yet")
    }
}
