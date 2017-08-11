//
//  SplashViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var subHeadingLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        if let bgImgData = UserDefaults.standard.value(forKey: STORED_BG_IMAGE) as? Data {
//            
//            if let img = UIImage(data: bgImgData) {
//                bgImgView.image = img
//            }
//        }
//        
//        if let logoImgData = UserDefaults.standard.value(forKey: STORED_LOGO_IMAGE) as? Data {
//            
//            if let img = UIImage(data: logoImgData) {
//                logoImgView.image = img
//            }
//        }
        
        CommonMethods.shared.addCornerRadius(toView: loginBtn, radius: 15.0, borderWidth: nil, borderColor: nil)
        
        if UserDefaults.standard.value(forKey: STORED_USERID) != nil {
            
            loginBtn.setTitle("Continue", for: .normal)
            registerBtn.isHidden = true
            
        }else {
            
            loginBtn.setTitle("LOGIN", for: .normal)
            registerBtn.isHidden = false
        }
        
        
        
        getData()
    }
    
    func getData() {
        
        var languageStr = "17"
        
        if let lngId = UserDefaults.standard.value(forKey: STORED_LANGUAGE_ID) as? String {
            
            languageStr = lngId
        }
        
        let params:[String:Any] = ["lang_id": languageStr]
        
        APIManager.shared.getSplashScreenData(parameters: params, showLoader: true) { (errorMessage, responseDict) in
            
            if errorMessage != nil {
                
                CommonMethods.shared.showAlertWith(title: "EducationApp", message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                return
            }
            
            if responseDict != nil {
                self.assignDataToView(dict: responseDict!)
            }
            
        }
        
        
    }
    
    func assignDataToView(dict:[String:AnyObject]) {
        
        if let status = dict[API_STATUS] as? String {
            
            if status == "true" {
                
                if let dataDict = dict[API_DATA] as? [String:AnyObject] {
                    
                    if let pageName = dataDict[PAGE_NAME] as? String {
                        
                        self.headingLbl.text = pageName
                        self.headingLbl.sizeToFit()
                    }
                    
                    if let description = dataDict[DESCRIPTION] as? String {
                        
                        do {
                            
                            if let convertedStr = try description.convertHtmlSymbols() {
                                
                                self.subHeadingLbl.text = convertedStr
                                self.subHeadingLbl.sizeToFit()
                            }
                            
                        }catch let error {
                            print(error.localizedDescription)
                        }
                    }
                    
                    if let bgImgStr = dataDict[BG_IMAGE] as? String {
                        
                        let imgURLString = IMAGE_SERVICE_URL + bgImgStr
                        
                        CommonMethods.shared.setImageTo(imgView: bgImgView, with: imgURLString, placeHolderImg: DEFAULT_BG_IMAGE!)
                        
                    }
                    
                    if let logoImgStr = dataDict[LOGO_IMAGE] as? String {
                        
                        let imgURLString = IMAGE_SERVICE_URL + logoImgStr
                        
                        CommonMethods.shared.setImageTo(imgView: logoImgView, with: imgURLString, placeHolderImg: DEFAULT_BG_IMAGE!)
                        
                    }
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        }
        
        
    }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        if let bgImg = bgImgView.image {
            
            if let data = UIImagePNGRepresentation(bgImg) {
                UserDefaults.standard.set(data, forKey: STORED_BG_IMAGE)
            }
            
        }
        
        if let logoImg = logoImgView.image {
            
            if let data = UIImagePNGRepresentation(logoImg) {
                UserDefaults.standard.set(data, forKey: STORED_LOGO_IMAGE)
            }
            
        }
        
        let sender = sender as! UIButton
        
        if sender.titleLabel?.text == "Continue" {
            
            // Show Home
            
            TransitionManager.shared.showHome()
            
        }else {
            self.performSegue(withIdentifier: "login", sender: self)
        }
        
        
    }

    @IBAction func registerBtnTapped(_ sender: Any) {
        
        if let bgImg = bgImgView.image {
            
            if let data = UIImagePNGRepresentation(bgImg) {
                UserDefaults.standard.set(data, forKey: STORED_BG_IMAGE)
            }
            
        }
        
        if let logoImg = logoImgView.image {
            
            if let data = UIImagePNGRepresentation(logoImg) {
                UserDefaults.standard.set(data, forKey: STORED_LOGO_IMAGE)
            }
            
        }
        
        self.performSegue(withIdentifier: "register", sender: self)
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

extension String {
    func convertHtmlSymbols() throws -> String? {
        guard let data = data(using: .utf8) else { return nil }
        
        return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).string
    }
}
