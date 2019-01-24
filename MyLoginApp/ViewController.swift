//
//  ViewController.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/24/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = +200}
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = 0}
        
        userTextField[0].delegate = self
        userTextField[1].delegate = self
    }

    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func enterHomeButton(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func registerAccountButton(_ sender: UIButton) {
        
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField[0] || textField == userTextField[1] {
            self.userTextField[0].resignFirstResponder()
            self.userTextField[1].resignFirstResponder()
        }
        return true
    }
}

extension String {
    func matchec(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
