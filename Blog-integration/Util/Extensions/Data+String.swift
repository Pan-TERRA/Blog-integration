//
//  Data+String.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 29.12.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

extension Data {
    
    var stringValue: String? {
        if let result = String(data: self, encoding: .utf8) {
            return result
        } else if let result = String(data: self, encoding: .ascii) {
            return result
        } else if let result = String(data: self, encoding: .unicode) {
            return result
        } else if let result = String(data: self, encoding: .windowsCP1251) {
            return result
        } else if let result = String(data: self, encoding: .macOSRoman) {
            return result
        } else {
            return nil
        }
    }
}
