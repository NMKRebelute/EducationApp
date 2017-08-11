//
//  APIManager.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class APIManager {
    
    
    //MARK: Singlaton
    
    static let shared:APIManager = {
        return APIManager()
    }()
    
    
    //MARK: Get splash screen data
    
    func getSplashScreenData(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ responseDict:[String:AnyObject]?) -> Void) {
        
        if showLoader == true {
            
            
        }
        
        HTTPClient.shared.getDataFromServerWith(URLString: Get_Splash_Screen_API, parameters: parameters) { (errorString, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    
                    
                }
                
                if errorString != nil {
                    completionBlock(errorString!, nil)
                    return
                }
                
                if responseDict != nil {
                    completionBlock(nil, responseDict!)
                }
                
            })
            
        }
        
    }
    
    
    
    
}
