//
//  LoginViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

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
        
        CommonMethods.shared.addCornerRadius(toView: fbBtn, radius: fbBtn.frame.size.width/2, borderWidth: 1.5, borderColor: EAColors.white)
        CommonMethods.shared.addCornerRadius(toView: gplusBtn, radius: gplusBtn.frame.size.width/2, borderWidth: 1.5, borderColor: EAColors.white)
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
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
