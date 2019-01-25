//
//  ViewController.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/24/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var data = Data()

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
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        homeViewController.data = data
        self.present(homeViewController, animated: true, completion: nil)
        
        _ = data.searchForAMatchInTheVault(userTextField[0].text!, userTextField[1].text!)
        _ = data.checkOnCorrectPassword(userTextField[0].text!, userTextField[1].text!)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField[0] || textField == userTextField[1] {
            self.userTextField[0].resignFirstResponder()
            self.userTextField[1].resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        let b = String.matches("^[a-zA-Z0-9._-]{1,30}$")
//        print(b)
    }
}


