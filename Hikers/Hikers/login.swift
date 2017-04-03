//
//  login.swift
//  Bite Me
//
//  Created by Rafi Rizwan on 2/19/17.
//  Copyright © 2017 vi66r. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class login: UIViewController, FBSDKLoginButtonDelegate {
    
    internal var signedInViaFacebook: Bool = false
    
    @IBOutlet var fbLoginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello there!")
        //        let fbLoginButton = FBSDKLoginButton()
        self.fbLoginButton.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
        }
        print("User Logged Out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("delegate called!")
        print("logged in!")
        if let error = error {
            print("operation failed! -- initial login step")
            print(error.localizedDescription)
            return
        }
        // ...
        signedInViaFacebook = true;
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if let error = error {
                print("operation failed! -- firebase login step")
                print(error.localizedDescription)
                return
            }
            //log in => push the home view controller!
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let home = storyboard.instantiateViewController(withIdentifier: "main")
            self.present(home, animated: true, completion: nil)
        }
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
