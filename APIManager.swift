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
            
            CommonMethods.shared.showLoaderWith(title: "Loading")
        }
        
        HTTPClient.shared.getDataFromServerWith(URLString: Get_Splash_Screen_API, parameters: parameters) { (errorString, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    
                    CommonMethods.shared.hideLoader()
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
    
    
    //MARK: LogIn User
    
    func logInUserWith(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ model:UserModel?) -> Void) {
        
        if showLoader == true {
            
            CommonMethods.shared.showLoaderWith(title: "Logging In You")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Login_User_API, parameters: parameters) { (errorString, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorString != nil {
                    completionBlock(errorString!, nil)
                }else {
                    
                    if responseDict != nil {
                        
                        if let status = responseDict?[API_STATUS] as? String {
                            
                            if status == "true" {
                                
                                if let userDict = responseDict?[USER_DETAILS] as? [String:AnyObject] {
                                    
                                    let model = UserModel(dict: userDict)
                                    
                                    completionBlock(nil, model)
                                    
                                }
                                
                            }else {
                                
                                if let message = responseDict?[API_ERROR_MESSAGE] as? String {
                                    completionBlock(message, nil)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    //MARK: Register User
    
    func registerUserWith(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ registered:Bool) -> Void) {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Registering you")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Register_User_API, parameters: parameters) { (errorMessage, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorMessage != nil {
                    
                    completionBlock(errorMessage!, false)
                    
                }else {
                    
                    if let status = responseDict?[API_STATUS] as? String {
                        
                        if status == "true" {
                            
                            completionBlock(nil, true)
                            
                        }else {
                            
                            if let message = responseDict?[API_ERROR_MESSAGE] as? String {
                                
                                completionBlock(message, false)
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    
}
