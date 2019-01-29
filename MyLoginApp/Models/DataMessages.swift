//
//  DataMessages.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/28/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

struct DataMessage {
    let emailAddressNotValid = "Email address is not valid!"
    let passwordNotFilled = "The password must be of 6 characters and contain at least one letter and number!"
    let incorretLoginOrPassword = "Incorrect login or password!"
    let emailAddressNotFound = "Email address not found in database! Or you entered incorrect email!"
    let emailAddressNotFill = "Please enter your email address!"
    let createAccountSuccesfull = "Your account has been successfully registered, return to the main menu and log in with your account."
    let passwordNotMatch = "Passwords do not match, check the correctness of input"
    let registerRecoverAlert = "Perhaps you would like to restore your account or register a new one?"
    let dataNilMessage = "Please enter your username and password"
    let passwordRecovery = "Your password is "
}
