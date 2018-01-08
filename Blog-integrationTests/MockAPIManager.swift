//
//  MockAPIManager.swift
//  Blog-integrationTests
//
//  Created by Vlad Krut on 08.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import Foundation
@testable import Blog_integration

class MockAPIManager: APIManager {
    
    override func getUsers(success: @escaping (Any) -> (), failure: @escaping (BlogError) -> ()) {
        
        var successValue = [String: Any]()
        
        (0..<5+arc4random_uniform(15)).forEach({ index in
            
            let id = UUID().uuidString
            let userJSON = ["id": id,
                            "email": UUID().uuidString,
                            "nickname": UUID().uuidString]
            
            successValue[id] = userJSON
        })
        
        success(successValue as Any)
    }
    
}
