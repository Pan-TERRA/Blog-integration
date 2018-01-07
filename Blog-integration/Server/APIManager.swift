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
    
    private func getAuthorizationHeader() -> [String: String]? {
        
        guard let token = UserDefaultsManager.default.getValue(valueType: String.self, forKey: .kUserToken) else { return nil }
        //print("TOKEN: \(token)")
        return ["Authorization": "Bearer \(token)"]
    }
    
    // MARK: - Authorization
    
//    func login(form: LoginForm, success: @escaping (Any)->(), failure: @escaping (BlogError)->()) {
//
//        var parameters = Mapper<LoginForm>().toJSON(form)
//
//        networking.makeRequest(path: "login", method: .post, parameters: parameters, headers: nil, success: success, failure: failure)
//    }
    
//    func registerUser(data: RegistrationForm, success: @escaping (Any)->(), failure: @escaping (BlogError)->()) {
//
//        var parameters = Mapper<RegistrationForm>().toJSON(data)
//
//        networking.makeRequest(path: "register", method: .post, parameters: parameters, headers: nil, success: success, failure: failure)
//    }
//
//    func confirmRegister(code: String, success: @escaping (Any)->(), failure: @escaping (BlogError)->()) {
//
//        var parametrs = [String: Any]()
//
//        parametrs["user_id"] = APIModels.shared.userProfile?.userID ?? 0
//        parametrs["code"] = code
//
//        networking.makeRequest(path: "check_digit_code", method: .post, parameters: parametrs, headers: nil, success: success, failure: failure)
//    }

    
    // MARK: - Profile
    
//    func getCurrentUser(success: @escaping (Any)->(), failure: @escaping (BlogError)->()) {
//
//        var parametrs = [String: Any]()
//
//        parametrs["id"] = APIModels.shared.userProfile?.userID ?? 0 // Да, здесь просто id,а не user_id
//
//        networking.makeRequest(path: "get_user", method: .post, parameters: parametrs, headers: nil, success: success, failure: failure)
//    }
    
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
}
