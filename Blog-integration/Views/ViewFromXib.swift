//
//  ViewFromXib.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class ViewFromXib: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fromNib()
    }
}
