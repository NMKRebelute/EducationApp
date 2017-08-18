//
//  CommonMethods.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit
import SDWebImage
import EZLoadingActivity

class CommonMethods {
    
    
    //MARK: Singlaton
    
    
    static let shared:CommonMethods = {
    
        return CommonMethods()
    }()
    
    
    //MARK: Common method to add corner radius
    
    
    func addCornerRadius(toView view:UIView, radius:CGFloat, borderWidth:CGFloat?, borderColor:UIColor?) {
        
        view.layer.cornerRadius = radius
        
        if borderWidth != nil {
            view.layer.borderWidth = borderWidth!
        }
        
        if borderColor != nil {
            view.layer.borderColor = borderColor?.cgColor
        }
        
        view.clipsToBounds = true
        
    }
    
    //MARK: Common method for showing alert
    
    func showAlertWith(title:String, message:String, sender:UIViewController, OKActionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
            OKActionHandler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(OKAction)
        alert.addAction(cancelAction)
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Common method for showing loader
    
    func showLoaderWith(title:String) {
        
        EZLoadingActivity.Settings.BackgroundColor = EAColors.white
        EZLoadingActivity.show(title, disableUI: true)
    }
    
    //MARK: Hide Loader
    
    func hideLoader() {
        
        EZLoadingActivity.hide()
    }
    
    //MARK: Common method for setting image to imageView
    
    func setImageTo(imgView:UIImageView, with URLString:String, placeHolderImg:UIImage) {
        
        if let imgURL = URL(string: URLString) {
            
            imgView.sd_setImage(with: imgURL, placeholderImage: placeHolderImg)
            return
        }
        
        imgView.image = placeHolderImg
        
    }
    
    //MARK: Common Method for Email validation
    
    func isValidEmail(testStr:String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //MARK: Convert HTML to string
    
    func convertHTMLToText(text:String) -> String {
        
        guard let data = text.data(using: .utf8) else {
            return ""
        }
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return ""
        }
        
        let decodedString = attributedString.string
        
        return decodedString
    }
    
    //MARK: LogOut the user 
    
    func logOutTheUser() {
        
        UserDefaults.standard.setValue(nil, forKey: STORED_USERID)
        UserDefaults.standard.setValue(nil, forKey: STORED_USERNAME)
        UserDefaults.standard.setValue(nil, forKey: STORED_FIRSTNAME)
        UserDefaults.standard.setValue(nil, forKey: STORED_LASTNAME)
        UserDefaults.standard.setValue(nil, forKey: STORED_EMAIL)
        UserDefaults.standard.setValue(nil, forKey: STORED_MOBILE)
        
        TransitionManager.shared.showLogin()
    }
    
}
