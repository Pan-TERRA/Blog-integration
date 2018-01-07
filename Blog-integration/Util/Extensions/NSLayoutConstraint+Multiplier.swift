//
//  NSLayoutConstraint+Multiplier.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 08.11.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
    
    /**
     Demo usage:
     
     @IBOutlet weak var myDemoConstraint: NSLayoutConstraint!
     
     override func viewDidLoad() {
     
     let newMultiplier: CGFloat = 0.80
     myDemoConstraint = myDemoConstraint.setMultiplier(newMultiplier)
     
     //If later in view lifecycle, you may need to call view.layoutIfNeeded()
     }
     */
}
