//
//  APIManager.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import FirebaseDatabase

enum ServerRequestError: Error {
    case emptyResponse
    case errorServer
    case errorAuthorization
}

class APIManager {
    
    let networking = Networking()
    let reference = Database.database().reference()
    
    init() {}
    
    // MARK: - Profile
    
    func updateUserProfile() {
        
        guard let user = AuthorizationManager.shared.userProfile else {
            return
        }
        
        let form = ["email": user.email!, "nickname": user.displayName!, "id": user.uid]
        
        reference.child("users/\(user.uid)").setValue(form)
    }
    
    func getUsers(success: @escaping (Any)->(), failure: @escaping (BlogError)->()) {
        
        reference.child("users").observeSingleEvent(of: .value, with: { snapshot in
            
            success(snapshot.value!)
            
        }, withCancel: { error in
            failure(BlogError(error: error))
        })
    }
    
    // MARK: - Posts
    
    func newPost(text: String, success: @escaping (Any)->(), failure: @escaping (BlogError)->()) {
        
        guard let user = AuthorizationManager.shared.userProfile else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: Date())
        
        let postID = UUID().uuidString
        
        let form = ["text": text, "id": postID, "user_id": user.uid, "date": stringDate]
        
        reference.child("posts/\(postID)").setValue(form, withCompletionBlock: { (error, _) in
            
            if error == nil {
                success("Success")
            } else {
                failure(BlogError(error: error!))
            }
            
        })
    }

}
