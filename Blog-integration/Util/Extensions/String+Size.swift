//
//  String+Size.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 27.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension String {
    
    func textHeightWithFont(font: UIFont, viewWidth: CGFloat, offset: CGFloat) -> CGFloat {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .justified
        paragraph.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: font as Any,
                                                         NSAttributedStringKey.paragraphStyle: paragraph as Any]
        
        let rectSize = CGSize(width: viewWidth - 2 * offset, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingRect = (self as NSString).boundingRect(with: rectSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        
        return ceil(boundingRect.size.height + 2 * offset)
    }
}


