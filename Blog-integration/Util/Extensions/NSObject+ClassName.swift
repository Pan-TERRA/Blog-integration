//
//  NSObject+ClassName.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
