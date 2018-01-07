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

enum ServerRequestError: Error {
    case emptyResponse
    case errorServer
    case errorAuthorization
}

class APIManager {
    
    let networking = Networking()
    
    init() {}
    
    private func getAuthorizationHeader() -> [String: String]? {
        
        guard let token = UserDefaultsManager.default.getValue(valueType: String.self, forKey: .kUserToken) else { return nil }
        //print("TOKEN: \(token)")
        return ["Authorization": "Bearer \(token)"]
    }
    
    // MARK: - Authorization
    
    func login(form: LoginForm, success: @escaping (Any)->(), failure: @escaping (SponsorhusetError)->()) {
        
        var parameters = Mapper<LoginForm>().toJSON(form)
        
        networking.makeRequest(path: "login", method: .post, parameters: parameters, headers: nil, success: success, failure: failure)
    }
    
    func registerUser(data: RegistrationForm, success: @escaping (Any)->(), failure: @escaping (SponsorhusetError)->()) {

        var parameters = Mapper<RegistrationForm>().toJSON(data)

        networking.makeRequest(path: "register", method: .post, parameters: parameters, headers: nil, success: success, failure: failure)
    }
    
    func confirmRegister(code: String, success: @escaping (Any)->(), failure: @escaping (SponsorhusetError)->()) {
        
        var parametrs = [String: Any]()
        
        parametrs["user_id"] = APIModels.shared.userProfile?.userID ?? 0
        parametrs["code"] = code
        
        networking.makeRequest(path: "check_digit_code", method: .post, parameters: parametrs, headers: nil, success: success, failure: failure)
    }

    
    // MARK: - Profile
    
    func getCurrentUser(success: @escaping (Any)->(), failure: @escaping (SponsorhusetError)->()) {
        
        var parametrs = [String: Any]()
        
        parametrs["id"] = APIModels.shared.userProfile?.userID ?? 0 // Да, здесь просто id,а не user_id

        networking.makeRequest(path: "get_user", method: .post, parameters: parametrs, headers: nil, success: success, failure: failure)
    }
    
    func updateUserProfile(form: ProfileForm, success: @escaping (Any)->(), failure: @escaping (SponsorhusetError)->()) {
        
        var parametrs = [String: Any]()
        
        parametrs["user_id"] = APIModels.shared.userProfile?.userID ?? 0
        parametrs["update"] = Mapper<ProfileForm>().toJSON(form)
        
        networking.makeRequest(path: "update_user", method: .post, parameters: parametrs, headers: nil, success: success, failure: failure)
    }
    
}
