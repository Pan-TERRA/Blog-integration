//
//  UIViewController+PreviousVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 13.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var previousVCInNavigationStack: UIViewController? {
        
        guard let controllers = navigationController?.viewControllers else { return nil }
        
        if controllers.count > 1 {
            return controllers[controllers.count - 2]
        }
        
        return nil
    }
    
}
