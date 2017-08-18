//
//  RegistrationViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
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
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        view.endEditing(true)
        
        if (firstNameTF.text?.characters.count)! > 0 && (lastNameTF.text?.characters.count)! > 0 && (emailTF.text?.characters.count)! > 0 && (userNameTF.text?.characters.count)! > 0 && (mobileTF.text?.characters.count)! > 0 && (passwordTF.text?.characters.count)! > 0 && (confirmPassTF.text?.characters.count)! > 0 {
            
            if CommonMethods.shared.isValidEmail(testStr: emailTF.text!) {
                
                if passwordTF.text == confirmPassTF.text {
                    
                    registerUser()
                    
                }else {
                    
                    CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Passwords doesn't match", sender: self, OKActionHandler: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                
            }else {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Please enter valid email", sender: self, OKActionHandler: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            
        }else {
            
            CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: "Please fill all the fields", sender: self, OKActionHandler: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
    func registerUser() {
        
        let params:[String:Any] = ["first_name":firstNameTF.text!, "last_name":lastNameTF.text!, "email":emailTF.text!, "mobile":mobileTF.text!, "password":passwordTF.text!, "username":userNameTF.text!]
        
        APIManager.shared.registerUserWith(parameters: params, showLoader: true) { (errorMessage, isRegistered) in
            
            if errorMessage != nil {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                
                return
            }
            
            if isRegistered == true {
                
                CommonMethods.shared.showAlertWith(title: "Registration Success!!", message: "Please Login with your credentials", sender: self, OKActionHandler: { 
                    
                    self.dismiss(animated: true, completion: nil)
                    
                    TransitionManager.shared.showLogin()
                })
                
            }
            
        }
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
