//
//  ViewController.swift
//  AccountAlertView
//
//  Created by Joe Nguyen on 13/08/2014.
//  Copyright (c) 2014 oneyenjug. All rights reserved.
//

import UIKit

let kInputBoxSize = 200.0 as CGFloat
let kInputBoxButtonHeight = 50.0 as CGFloat
let kInputBoxViewSpacing = 20.0 as CGFloat

class ViewController: UIViewController {
    
    var accountAlertView: AccountAlertView = AccountAlertView()
    var isRequestSuccessful: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccountAlertView()
        
        setupViews()
        
        accountAlertView.showAccountAlert()
    }
    
    func setupAccountAlertView() {
        
        accountAlertView.loginWithUsername = {
            (username: String!, password: String!, completed: () -> (), failed: (message: String!) -> ()) in
            
            if self.isRequestSuccessful {
                completed()
            } else {
                failed(message: "Failed Request.")
            }
        }
        
        accountAlertView.signUpWithUsername = {
            (username: String!, password: String!, completed: () -> (), failed: (message: String!) -> ()) in
            
            if self.isRequestSuccessful {
                completed()
            } else {
                failed(message: "Failed Request.")
            }
        }
    }
    
    func setupViews() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        // input box
        let inputBox = UIView(frame: CGRectMake(0.0, 0.0, kInputBoxSize, kInputBoxSize))
        inputBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(inputBox)
        
        // constraints
        var views = ["superview": view, "inputBox": inputBox]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[superview]-(<=1)-[inputBox(\(kInputBoxSize))]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[superview]-(<=1)-[inputBox(\(kInputBoxSize))]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: views))
        
        // start button
        let startButton = UIButton(frame: CGRectMake(0.0, 0.0, kInputBoxSize, kInputBoxButtonHeight))
        startButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        startButton.layer.borderWidth = 0.5
        startButton.layer.cornerRadius = 4.0
        startButton.titleLabel.font = UIFont.systemFontOfSize(14.0)
        startButton.setTitle("Start Account Alert View", forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        startButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        startButton.addTarget(self, action: "startAccountAlertView", forControlEvents: UIControlEvents.TouchUpInside)
        inputBox.addSubview(startButton)
        
        views = ["inputBox": inputBox, "startButton": startButton]
        inputBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[inputBox]-(<=1)-[startButton(\(kInputBoxButtonHeight))]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views))
        inputBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[inputBox]-(<=1)-[startButton(\(kInputBoxSize))]",
            options: NSLayoutFormatOptions.AlignAllTop,
            metrics: nil,
            views: views))
        
        let successfulRequestSwitch = UISwitch()
        successfulRequestSwitch.on = true
        successfulRequestSwitch.setTranslatesAutoresizingMaskIntoConstraints(false)
        successfulRequestSwitch.addTarget(self, action: "toggleSuccessfulRequest:", forControlEvents: UIControlEvents.ValueChanged)
        inputBox.addSubview(successfulRequestSwitch)
        
        let successfulRequestLabel = UILabel()
        successfulRequestLabel.text = "Successful Request: "
        successfulRequestLabel.font = UIFont.systemFontOfSize(12.0)
        successfulRequestLabel.textAlignment = NSTextAlignment.Right
        successfulRequestLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        inputBox.addSubview(successfulRequestLabel)
        
        views = ["inputBox": inputBox, "startButton": startButton, "successfulRequestLabel": successfulRequestLabel, "successfulRequestSwitch": successfulRequestSwitch]
        inputBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[startButton]-\(kInputBoxViewSpacing)-[successfulRequestLabel(\(successfulRequestSwitch.frame.size.height))]",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: views))
        inputBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[startButton]-\(kInputBoxViewSpacing)-[successfulRequestSwitch]",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: views))
        inputBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[successfulRequestLabel]-[successfulRequestSwitch]-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: views))
    }
    
    // Actions
    
    func startAccountAlertView() {
        
        accountAlertView.showAccountAlert()
    }
    
    func toggleSuccessfulRequest(sender: AnyObject!) {
        
        if let successfulRequestSwitch = sender as? UISwitch {
            
            isRequestSuccessful = successfulRequestSwitch.on
            
            accountAlertView.shouldReturnToStartWhenFailed = successfulRequestSwitch.on
        }
    }
}

