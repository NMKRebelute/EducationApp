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
    
    @IBOutlet weak var forgotPassBackView: UIView!
    @IBOutlet weak var forgotPassEmailTF: UITextField!
    
    @IBOutlet weak var forgotViewHeight: NSLayoutConstraint!
    
    
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
        
        forgotPassBackView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        forgotPassBackView.isHidden = true
        forgotViewHeight.constant = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.forgotBackViewTapped))
        forgotPassBackView.isUserInteractionEnabled = true
        forgotPassBackView.addGestureRecognizer(tap)
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    func forgotBackViewTapped() {
        
        forgotViewHeight.constant = 0
        
        UIView.animate(withDuration: 0.5) {
            
            self.forgotPassBackView.isHidden = true
            
            self.view.layoutIfNeeded()
            
        }
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        
        view.endEditing(true)
        
        if (emailTF.text?.characters.count)! > 0 && (passwordTF.text?.characters.count)! > 0 {
            
            if CommonMethods.shared.isValidEmail(testStr: emailTF.text!) {
                
                signInUser()
                
            }else {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Please enter a valid email", sender: self, OKActionHandler: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
        }else {
            
            CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Please fill all the fields", sender: self, OKActionHandler: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
    @IBAction func forgotPasswordBtnTapped(_ sender: Any) {
        
        forgotViewHeight.constant = 150
        
        UIView.animate(withDuration: 1.0) { 
            
            self.forgotPassBackView.isHidden = false
            self.view.bringSubview(toFront: self.forgotPassBackView)
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    @IBAction func sendForgetDataTapped(_ sender: Any) {
        
        view.endEditing(true)
        
        if forgotPassEmailTF.text?.characters.count == 0 {
            
            CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Please Enter the E-mail", sender: self, OKActionHandler: {
                self.dismiss(animated: true, completion: nil)
            })
            
        }else {
            
            if CommonMethods.shared.isValidEmail(testStr: forgotPassEmailTF.text!) {
                
                sendForgetPasswordData()
                
            }else {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Please Enter valid E-mail", sender: self, OKActionHandler: {
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
        }
        
//        forgotViewHeight.constant = 0
//        
//        UIView.animate(withDuration: 0.5) {
//            
//            self.forgotPassBackView.isHidden = true
//            
//            self.view.layoutIfNeeded()
//            
//        }
    }
    
    func sendForgetPasswordData() {
        
        let params:[String:Any] = ["email":forgotPassEmailTF.text!]
        
        APIManager.shared.sendForgetPasswordDataWith(parameters: params, showLoader: true) { (errorString, responseDict) in
            
            if errorString != nil {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorString!, sender: self, OKActionHandler: {
                    
                    self.dismiss(animated: true, completion: nil)
                })
             return
            }
            
            if responseDict != nil {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "We have send email so please check your email id", sender: self, OKActionHandler: {
                    
                    self.forgotViewHeight.constant = 0
                    
                    UIView.animate(withDuration: 0.5) {
                        
                        self.forgotPassBackView.isHidden = true
                        
                        self.view.layoutIfNeeded()
                        
                    }

                    self.dismiss(animated: true, completion: nil)
                })
                
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

                    var params:[String:Any] = [:]
                    
                    if let userDict = result as? [String:AnyObject] {
                        
                        
                        if let emailID = userDict["email"] as? String {
                            params["email"] = emailID
                        }
                        
                        if let firstName = userDict["first_name"] as? String {
                            params["first_name"] = firstName
                        }
                        
                        if let lastName = userDict["last_name"] as? String {
                            params["last_name"] = lastName
                        }
                        
                        if userDict["id"] != nil {
                            params["unique_id"] = "\(userDict["id"]!)"
                        }
                        
                        if let picDict = userDict["picture"] as? [String:AnyObject] {
                            
                            if let dataDict = picDict["data"] as? [String:AnyObject] {
                                
                                if let URLString = dataDict["url"] as? String {
                                    params["image_url"] = URLString
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    self.logInUserWithSocialLogins(loginType: 0, parameters: params)
                    
                }
            })
        }
    }
    
    @IBAction func gplusBtnTapped(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signInUser() {
        
        let params:[String:Any] = ["email":emailTF.text!, "password":passwordTF.text!]
        
        APIManager.shared.logInUserWith(parameters: params, showLoader: true) { (errorMessage, model) in
            
            if errorMessage != nil {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: {
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
    
    func logInUserWithSocialLogins(loginType:Int, parameters:[String:Any]) {
        
        // if loginType = 0 ----> Facebook Login, if loginType = 1 ----> Google Login
        
        var params:[String:Any] = parameters
        
        APIManager.shared.logInUserWithSocialLogins(parameters: params, showLoader: true) { (errorMessage, model) in
            
            if errorMessage != nil {
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: {
                    self.dismiss(animated: true, completion: nil)
                })
                
                return
            }
            
            if (model?.uniqueID.characters.count)! > 0 {
                
                UserDefaults.standard.setValue(model?.uniqueID, forKey: STORED_USERID)
                UserDefaults.standard.setValue(model?.firstName, forKey: STORED_FIRSTNAME)
                UserDefaults.standard.setValue(model?.lastName, forKey: STORED_LASTNAME)
                UserDefaults.standard.setValue(model?.email, forKey: STORED_EMAIL)
                
                TransitionManager.shared.showHome()
                
            }
            
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

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            
            let userId = user.userID
//            let idToken = user.authentication.idToken 
//            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            var params:[String:Any] = [:]
            
            if email != nil {
                params["email"] = email!
            }
            
            if givenName != nil {
                params["first_name"] = givenName!
            }
            
            if familyName != nil {
                params["last_name"] = familyName!
            }
            
            if userId != nil {
                params["unique_id"] = userId!
            }
            
            if user.profile.hasImage == true {
                let imgURL = user.profile.imageURL(withDimension: 400)
                
                if imgURL != nil {
                    params["image_url"] = imgURL!
                }
                
            }
            
            logInUserWithSocialLogins(loginType: 1, parameters: params)
            
            
        } else {
            CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: error.localizedDescription, sender: self, OKActionHandler: { 
                self.dismiss(animated: true, completion: nil)
            })
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
