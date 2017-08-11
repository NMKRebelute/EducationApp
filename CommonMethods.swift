//
//  CommonMethods.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


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
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIALERTACTION) in
            
            OKActionHandler()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(OKAction)
        alert.addAction(cancelAction)
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
}
