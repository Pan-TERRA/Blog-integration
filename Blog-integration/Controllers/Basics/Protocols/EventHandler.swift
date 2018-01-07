//
//  ErrorHandler.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//


import UIKit

enum ErrorType: String {
    case serverError = "Error connection to server. Please, try later"
    case loadingLocationError = "Error loading location. Please, try again"
}

protocol EventHandler {
    
}

extension EventHandler {
    
    func showAlertWith(error: ErrorType, controller: UIViewController?, completion: ((UIAlertAction)->())? = nil) {
        showAlertWith(text: error.rawValue, controller: controller)
    }
    
    func showAlertWith(text: String, controller: UIViewController?, completion: ((UIAlertAction)->())? = nil) {
        
        let alertVC = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: completion)
        alertVC.addAction(okAction)
        
        controller?.present(alertVC, animated: true, completion: nil)
    }
    
    func showInfoLabelWithText(_ text: String, controller: UIViewController?, appearanceTime: Double = 0.3, duration: Double = 1.0) {
        
        guard controller != nil else { return }
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.brandColor
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame.size = label.sizeThatFits(.init(width: UIWindow.size.width - 50, height: .greatestFiniteMagnitude))
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.cornerRadius = 12.0
        view.clipsToBounds = true
        view.frame.size = .init(width: label.frame.width + 16.0, height: label.frame.height + 16.0)
        view.borderColor = UIColor.brandColor
        view.borderWidth = 2.0
        
        view.addSubview(label)
        label.center = view.center
        
        controller!.view.addSubview(view)
        view.center = .init(x: controller!.view.center.x, y: controller!.view.bounds.height - 32.0 - view.frame.height)
        view.alpha = 0.0
        
        UIView.animate(withDuration: appearanceTime, animations: {
            view.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: appearanceTime, delay: duration, animations: {
                view.alpha = 0.0
            }, completion: { _ in
                view.removeFromSuperview()
            })
        })
    }
}

