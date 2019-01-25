//
//  RegisterViewController.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/25/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField[0].delegate = self
        userTextField[1].delegate = self
    }
    
    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        _ = data.registerAccount(userTextField[0].text!, userTextField[1].text!)
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        loginViewController.data = data
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField[0] || textField == userTextField[1] {
            self.userTextField[0].resignFirstResponder()
            self.userTextField[1].resignFirstResponder()
        }
        return true
    }
    
}
