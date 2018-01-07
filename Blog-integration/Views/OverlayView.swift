//
//  OverlayView.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 05.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

/// This UIView subclass just ignore all touches and send them to the next responder
class OverlayView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
}

