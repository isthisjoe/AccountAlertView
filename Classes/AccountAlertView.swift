//
//  AccountAlertView.swift
//  HopscotchApp
//
//  Created by Joe Nguyen on 12/08/2014.
//  Copyright (c) 2014 oneyenjug. All rights reserved.
//

import Foundation
import UIKit

class AccountAlertView: UIView {
    
    class var bundleName: String {
        get {
            return NSBundle.mainBundle().infoDictionary[kCFBundleNameKey as NSString]! as String
        }
    }
    
    // Required Closures
    var loginWithUsername: ((String!, password: String!, completed: () -> (), failed: (message: String!) -> ()) -> ())!
    var signUpWithUsername: ((String!, password: String!, completed: () -> (), failed: (message: String!) -> ()) -> ())!
    
    // Config values
    var isCancellable = false
    var shouldReturnToStartWhenFailed = true
    
    // Optional Text values
    var mainAccountAlertTitle = "Login or Sign Up"
    var mainAccountAlertMessage = "Create an account to start using \(AccountAlertView.bundleName)."
    var mainAccountLoginButtonText = "Login"
    var mainAccountSignUpButtonText = "Sign Up"
    var mainAccountCancelButtonText = "Cancel"
    
    var loginAlertTitle = "Login"
    var loginAlertMessage = "Enter a username and password."
    var loginAlertCancelButtonText = "Cancel"
    var loginAlertSubmitButtonText = "Login"
    
    var loginCompletedAlertTitle = "Hi again"
    var loginCompletedAlertMessage = "Welcome back to \(AccountAlertView.bundleName)."
    var loginCompletedAlertOKButtonText = "OK"
    
    var loginFailedAlertTitle = "Oops"
    var loginFailedAlertMessage = "There was an error. Please try again."
    var loginFailedAlertOKButtonText = "OK"
    
    var signUpAlertTitle = "Sign Up"
    var signUpAlertMessage = "Enter a username and password"
    var signUpAlertCancelButtonText = "Cancel"
    var signUpAlertSubmitButtonText = "Sign Up"
    
    var signUpCompletedAlertTitle = "Great!"
    var signUpCompletedAlertMessage = "Sign up done."
    var signUpCompletedAlertOKButtonText = "OK"
    
    var signUpFailedAlertTitle = "Oops"
    var signUpFailedAlertMessage = "There was an error. Please try again."
    var signUpFailedAlertOKButtonText = "OK"
    
    // Alert views
    var mainAccountAlertView: UIAlertView!
    var loginAlertView: UIAlertView!
    var loginCompletedAlertView: UIAlertView!
    var loginFailedAlertView: UIAlertView!
    var signUpAlertView: UIAlertView!
    var signUpCompletedAlertView: UIAlertView!
    var signUpFailedAlertView: UIAlertView!
    
    func showAccountAlert() {
        
        assert(loginWithUsername != nil, "Must declare a function for loginWithUsername.")
        assert(signUpWithUsername != nil, "Must declare a function for signUpWithUsername.")
        
        if !mainAccountAlertView {
            
            mainAccountAlertView = UIAlertView(title: mainAccountAlertTitle,
                message: mainAccountAlertMessage,
                delegate: self,
                cancelButtonTitle: nil)
            mainAccountAlertView.addButtonWithTitle(mainAccountLoginButtonText)
            mainAccountAlertView.addButtonWithTitle(mainAccountSignUpButtonText)
            
            if isCancellable {
                mainAccountAlertView.addButtonWithTitle(mainAccountCancelButtonText)
            }
        }
        mainAccountAlertView.show()
    }
    
    func loginWithUsername(username: String!, password: String!) {
        
        if loginWithUsername {
            
            loginWithUsername(username,
                password: password,
                completed: {
                    
                    if !self.loginCompletedAlertView {
                        
                        self.loginCompletedAlertView =
                            UIAlertView(title: self.loginCompletedAlertTitle,
                                message: self.loginCompletedAlertMessage,
                                delegate: self,
                                cancelButtonTitle: self.loginCompletedAlertOKButtonText)
                    }
                    self.loginCompletedAlertView.show()
                    
                },
                failed: { (message: String!) in
                    
                    var errorMessage: String! = nil
                    if message != nil {
                        errorMessage = message
                    } else {
                        errorMessage = self.loginFailedAlertMessage
                    }
                    
                    if !self.loginFailedAlertView {
                        
                        self.loginFailedAlertView = UIAlertView(title: self.loginFailedAlertTitle,
                            message: errorMessage,
                            delegate: self,
                            cancelButtonTitle: self.loginFailedAlertOKButtonText)
                    }
                    self.loginFailedAlertView.show()
            })
        }
    }
    
    func signUpWithUsername(username: String, password: String) {
        
        if signUpWithUsername {
            
            signUpWithUsername(username,
                password: password,
                completed: {
                    
                    if !self.signUpCompletedAlertView {
                        
                        self.signUpCompletedAlertView = UIAlertView(title: self.signUpCompletedAlertTitle,
                            message: self.signUpCompletedAlertMessage,
                            delegate: self,
                            cancelButtonTitle: self.signUpCompletedAlertOKButtonText)
                    }
                    self.signUpCompletedAlertView.show()
                },
                failed: { (message: String!) in
                    
                    var errorMessage: String! = nil
                    if message != nil {
                        errorMessage = message
                    } else {
                        errorMessage = self.signUpFailedAlertMessage
                    }
                    
                    if !self.signUpFailedAlertView {
                        
                        self.signUpFailedAlertView = UIAlertView(title: self.signUpFailedAlertTitle,
                            message: errorMessage,
                            delegate: self,
                            cancelButtonTitle: self.signUpFailedAlertOKButtonText)
                    }
                    self.signUpFailedAlertView.show()
            })
        }
    }
}

extension AccountAlertView: UIAlertViewDelegate {
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        
        switch alertView {
        case let mainAccountAlertView where self.mainAccountAlertView != nil && mainAccountAlertView == self.mainAccountAlertView:
            
            switch buttonIndex {
            case 0: // login
                loginAlertView = UIAlertView(title: loginAlertTitle,
                    message: loginAlertMessage,
                    delegate: self,
                    cancelButtonTitle: loginAlertCancelButtonText,
                    otherButtonTitles: loginAlertSubmitButtonText)
                loginAlertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                loginAlertView.show()
                
            case 1: // sign up
                signUpAlertView = UIAlertView(title: signUpAlertTitle,
                    message: signUpAlertMessage,
                    delegate: self,
                    cancelButtonTitle: signUpAlertCancelButtonText,
                    otherButtonTitles: signUpAlertSubmitButtonText)
                signUpAlertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
                signUpAlertView.show()
                
            default:
                ""
            }
            
        case let loginAlertView where self.loginAlertView != nil && loginAlertView == self.loginAlertView:
            
            let usernameField = alertView.textFieldAtIndex(0)
            let passwordField = alertView.textFieldAtIndex(1)
            
            switch buttonIndex {
            case 0:
                self.mainAccountAlertView.show()
                
            case 1: // login?
                loginWithUsername(usernameField.text, password:passwordField.text)
                
            default:
                ""
            }
            
        case let loginFailedAlertView where self.loginFailedAlertView != nil && loginFailedAlertView == self.loginFailedAlertView:
            
            if shouldReturnToStartWhenFailed {
                loginAlertView.show()
            }
            
        case let signUpAlertView where self.signUpAlertView != nil && signUpAlertView == self.signUpAlertView:
            
            let usernameField = alertView.textFieldAtIndex(0)
            let passwordField = alertView.textFieldAtIndex(1)
            
            switch buttonIndex {
            case 0: // cancel?
                self.mainAccountAlertView.show()
                
            case 1: // login?
                signUpWithUsername(usernameField.text, password:passwordField.text)
                
            default:
                ""
            }
            
        case let signUpFailedAlertView where self.signUpFailedAlertView != nil && signUpFailedAlertView == self.signUpFailedAlertView:
            
            if shouldReturnToStartWhenFailed {
                signUpAlertView.show()
            }
            
        default:
            ""
        }
    }
}

