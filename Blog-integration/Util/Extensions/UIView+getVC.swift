//
//  UIView+getVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 17.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension UIView {
    
    var viewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
