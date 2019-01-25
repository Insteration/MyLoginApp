//
//  Data.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/24/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

struct Data {
    
    var dataStorage: [String: String] = ["inste@icloud.com": "123456", "inste@me.com": "112233", "admin": "admin"]
    
    func searchForAMatchInTheVault(_ emailData: String, _ passwordData: String) -> Bool {
        for search in dataStorage {
            if search.key == emailData {
                print("Found email login in DataStorage! Matching a value by key!")
                if search.value == passwordData {
                    print("Login = \(search.key), password = \(search.value)")
                    print("Success!")
                    return true
                }
            }
        }
        print("Not found matches in Storage!")
        return false
    }
    
    func checkOnCorrectPassword(_ emailData: String, _ passwordData: String) -> Bool {
        
        return true
    }
    
    mutating func registerAccount(_ emailData: String, _ passwordData: String) {
        dataStorage.updateValue(emailData, forKey: passwordData)
        
        for i in dataStorage {
            print("Login = \(i.key), password = \(i.value)")
        }
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

//
//func textFieldDidEndEditing(_ textField: UITextField) {
//
//    //        let b = String.matches("^[a-zA-Z0-9._-]{1,30}$")
//    //        print(b)
//}
