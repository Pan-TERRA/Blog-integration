//
//  TopUsersVC.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit
import ObjectMapper

class TopUsersVC: MappableTableVC {
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataFromServer(completionHandler: nil)
    }
    
    // MARK: - Data
    
    override func loadDataFromServer(completionHandler: ((Error?) -> ())?) {
        
        mappables.removeAll()
        
        apiManager.getUsers(success: { [weak self] response in
            
            guard let items = response as? [String: Any] else { return }
            
            let mapper = Mapper<ProfileModel>()
            
            for entry in items {
                guard let jsonUser = entry.value as? [String: Any] else { continue }
                
                if let user = mapper.map(JSON: jsonUser) {
                    self?.mappables.append(user)
                }
                
            }
            
            if completionHandler != nil {
                completionHandler!(nil)
            } else {
                self?.tableView.reloadData()
            }
            
        }, failure: { error in
            print(error.localizedDescription)
            completionHandler?(error)
        })
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        guard let user = mappables[indexPath.section] as? ProfileModel else { return }
        
        let vc = AnotherBlogVC()
        vc.user = user
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
