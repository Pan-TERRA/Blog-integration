//
//  SponsorhusetError.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Alamofire

class SponsorhusetError: Error {
    
    let error: Error
    let readableData: String?
    let statusCode: Int?
    
    var afError: AFError? {
        return error as? AFError
    }
    
    init(error: Error, readableData: String? = nil, statusCode: Int? = nil) {
        self.error = error
        self.readableData = readableData
        self.statusCode = statusCode
    }
    
    var localizedDescription: String {
        return readableData ?? error.localizedDescription
    }
}
