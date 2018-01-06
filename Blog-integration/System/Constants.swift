//
//  Constants.swift
//  Blog-integration
//
//  Created by Vlad Krut on 06.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import Foundation

func printCurrentTag() {
    print("Runtime. Git tag: \(getGitTag() ?? "null")")
}

func getGitTag() -> String? {
    guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let plist = NSDictionary(contentsOfFile: path), let tag = plist["GitTag"] as? String else {
        return nil
    }
    
    return tag
}
