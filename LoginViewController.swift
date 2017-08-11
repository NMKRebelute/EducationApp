//
//  LoginViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class LoginViewController: UIViewController {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var gplusBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
    @IBOutlet weak var logoImgView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let bgImgData = UserDefaults.standard.value(forKey: STORED_BG_IMAGE) as? Data {
            
            if let img = UIImage(data: bgImgData) {
                bgImgView.image = img
            }
        }
        
        if let logoImgData = UserDefaults.standard.value(forKey: STORED_LOGO_IMAGE) as? Data {
            
            if let img = UIImage(data: logoImgData) {
                logoImgView.image = img
            }
        }
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        
        view.endEditing(true)
        
        if (emailTF.text?.characters.count)! > 0 && (passwordTF.text?.characters.count)! > 0 {
            
            if CommonMethods.shared.isValidEmail(testStr: emailTF.text!) {
                
                signInUser()
                
            }else {
                
                CommonMethods.shared.showAlertWith(title: "EducationApp", message: "Please enter a valid email", sender: self, OKActionHandler: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
        }else {
            
            CommonMethods.shared.showAlertWith(title: "EducationApp", message: "Please fill all the fields", sender: self, OKActionHandler: { 
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
    func signInUser() {
        
        let params:[String:Any] = ["email":emailTF.text!, "password":passwordTF.text!]
        
        APIManager.shared.logInUserWith(parameters: params, showLoader: true) { (errorMessage, model) in
            
            if errorMessage != nil {
                
                CommonMethods.shared.showAlertWith(title: "EducationApp", message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                
                return
            }
            
            if model != nil {
                
                if (model?.userID.characters.count)! > 0 {
                    
                    UserDefaults.standard.setValue(model?.userID, forKey: STORED_USERID)
                    UserDefaults.standard.setValue(model?.userName, forKey: STORED_USERNAME)
                    UserDefaults.standard.setValue(model?.firstName, forKey: STORED_FIRSTNAME)
                    UserDefaults.standard.setValue(model?.lastName, forKey: STORED_LASTNAME)
                    UserDefaults.standard.setValue(model?.emailId, forKey: STORED_EMAIL)
                    UserDefaults.standard.setValue(model?.mobileNumber, forKey: STORED_MOBILE)
                    
                    
                    TransitionManager.shared.showHome()
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "register", sender: self)
    }
    
    @IBAction func faceBookBtnTapped(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = .browser
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
//                    self.dict = result as! [String : AnyObject]
                    print(result!)
//                    print(self.dict)
                }
            })
        }
    }
    
    @IBAction func gplusBtnTapped(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
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

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        } else {
            
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print(error.localizedDescription)
    }
    
}

extension LoginViewController: GIDSignInUIDelegate {
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
