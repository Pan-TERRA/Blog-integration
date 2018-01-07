//
//  UIView+Shadow.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 26.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension UIView {
    
    func dropShadow(color: UIColor = UIColor.black, opacity: Float = 0.5, offSet: CGSize = .zero, radius: CGFloat = 8, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

