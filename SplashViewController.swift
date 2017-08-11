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
        
        CommonMethods.shared.addCornerRadius(toView: loginBtn, radius: 20.0, borderWidth: nil, borderColor: nil)
        loginBtn.setTitle("LOGIN", for: .normal)
        
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
                    }
                    
                    if let description = dataDict[DESCRIPTION] as? String {
                        
                        do {
                            
                            if let convertedStr = try description.convertHtmlSymbols() {
                                
                                self.subHeadingLbl.text = convertedStr
                            }
                            
                        }catch let error {
                            print(error.localizedDescription)
                        }
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "login", sender: self)
    }

    @IBAction func registerBtnTapped(_ sender: Any) {
        
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
