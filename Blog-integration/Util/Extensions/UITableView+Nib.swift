//
//  UITableView+Nib.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 05.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNibs(_ nibNames: [String]) {
        
        nibNames.forEach({
            register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        })
        
    }
}

extension UICollectionView {
    
    func registerNibs(_ nibNames: [String]) {
        
        nibNames.forEach({
            register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        })
        
    }
}
