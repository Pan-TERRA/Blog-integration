//
//  ModalVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class ModalVC: BasicVC {
    
    var blurView: UIVisualEffectView!
    
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        
        modalPresentationStyle = .overCurrentContext
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        let blur = UIBlurEffect(style: blurStyle)
        blurView = UIVisualEffectView(effect: blur)
        
        view.insertSubview(blurView, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        blurView.frame = view.bounds
    }
    
    private var _blurStyle: UIBlurEffectStyle = .light
    var blurStyle: UIBlurEffectStyle {
        get {
            return _blurStyle
        } set {
            _blurStyle = newValue
            blurView.effect = UIBlurEffect(style: _blurStyle)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
