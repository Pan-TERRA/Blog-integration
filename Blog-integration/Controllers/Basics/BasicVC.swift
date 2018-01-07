//
//  BasicVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class BasicVC: UIViewController, EventHandler {

    var loadingView: LoadingView?
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(colorWithHexValue: 0xF5F5F5)
    }

    
    // MARK: - Navigation
    
    func backDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    func enableBackSwipeGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Loading
    
    func startLoading() {
        
        if loadingView == nil {
            loadingView = LoadingView(frame: view.bounds)
            view.addSubview(loadingView!)
        }
    }
    
    func stopLoading() {
        
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    // MARK: - User Interaction
    
    func disableUserInteractionFor(time: Double) {
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
            self.view.isUserInteractionEnabled = true
        })
    }
    
}
