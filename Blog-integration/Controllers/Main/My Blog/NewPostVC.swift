//
//  NewPostVC.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class NewPostVC: BasicVC {
    
    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Actions

    @IBAction func sendTapped(_ sender: UIButton) {
        send()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func send() {
        
        guard let text = textView.text, !text.isEmpty else {
            showInfoLabelWithText("Field cannot be empty", controller: self)
            return
        }
        
        startLoading()
        
        apiManager.newPost(text: text, success: { [weak self] response in
            self?.stopLoading()
            print(response)
            self?.navigationController?.popViewController(animated: true)
        }, failure: { [weak self] error in
            self?.stopLoading()
            self?.showAlertWith(text: error.localizedDescription, controller: self)
        })
    }
}

extension NewPostVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        if text == "\n" {
            textView.resignFirstResponder()
            send()
            return false
        }
        
        return newText.count < 300;
    }
    
    
}
