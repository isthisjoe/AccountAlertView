# AccountAlertView

[![Version](http://cocoapod-badges.herokuapp.com/v/ORStackView/badge.png)](http://cocoadocs.org/docsets/ORStackView)
[![Platform](http://cocoapod-badges.herokuapp.com/p/ORStackView/badge.png)](http://cocoadocs.org/docsets/ORStackView)

Simple, quick account flow using UIAlertViews.

Written in Swift.

### AccountAlertView

A highly configurable login / sign up account flow using only UIAlertViews. 


```objc

var accountAlertView: AccountAlertView = AccountAlertView()

...

override func viewDidLoad() {
    
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
    
    accountAlertView.showAccountAlert()
}

```

## Author

Joe Nguyen, isthisjoe@gmail.com

## License

AccountAlertView is available under the MIT license. See the LICENSE file for more info.
