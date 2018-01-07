//
//  PlaceholderTextView.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 06.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class PlaceholderTextView: KMPlaceholderTextView {

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
