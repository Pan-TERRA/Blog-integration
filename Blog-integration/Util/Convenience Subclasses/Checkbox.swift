//
//  Checkbox.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 20.11.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class Checkbox: UIButton {
    
    // Images
    let checkedImage = UIImage(named: "checkboxChecked")! as UIImage
    let uncheckedImage = UIImage(named: "checkboxNonChecked")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
}
