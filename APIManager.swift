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
    
    
    //MARK: Social Login
    
    func logInUserWithSocialLogins(parameters:[String:Any], showLoader:Bool, completionBlock:@escaping(_ errorMessage:String?, _ model:SocialUserModel?) -> Void) {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Logging You")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Social_Login_API, parameters: parameters) { (errorString, responseDict) in
            
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
                                
                                if let userDict = responseDict?["user_details"] as? [String:AnyObject] {
                                    
                                    let model = SocialUserModel(dict: userDict)
                                    
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
    
    
    //MARK: Send forget password data
    
    
    func sendForgetPasswordDataWith(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ responseDict:[String:AnyObject]?) -> Void) {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Please Wait")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Forget_Password_API, parameters: parameters) { (errorMessage, responsedict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorMessage != nil {
                    completionBlock(errorMessage!, nil)
                }else {
                    
                    if responsedict != nil {
                        
                        if let status = responsedict?[API_STATUS] as? String {
                            
                            if status == "true" {
                                
                                completionBlock(nil, responsedict!)
                                
                            }else {
                                
                                if let message = responsedict?[API_ERROR_MESSAGE] as? String {
                                    
                                    completionBlock(message, nil)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    
    //MARK: Get HomeScreen Data
    
    func getHomeScreenDataWith(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ responseDict:[String:AnyObject]?) -> Void) {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Please wait")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Get_HomeScreen_API, parameters: parameters) { (errorMessage, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorMessage != nil {
                    completionBlock(errorMessage!, nil)
                }else {
                    
                    if responseDict != nil {
                        
                        if let status = responseDict?[API_STATUS] as? String {
                            
                            if status == "true" {
                                
                                completionBlock(nil, responseDict!)
                                
                            }else {
                                
                                var errorMessage = "Connection Failed"
                                
                                if let message = responseDict?[API_ERROR_MESSAGE] as? String {
                                    
                                    errorMessage = message
                                }
                                
                                completionBlock(errorMessage, nil)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    
    //MARK: Get Menu data
    
    
    func getMenuDataWith(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ modelArray:[MenuModel]?) -> Void)  {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Please wait")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Get_Menu_API, parameters: parameters) { (errorMessage, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorMessage != nil {
                    completionBlock(errorMessage!, nil)
                }else {
                    
                    if responseDict != nil {
                        
                        if let status = responseDict?[API_STATUS] as? String {
                            
                            if status == "true" {
                                
                                var modelArray:[MenuModel] = []
                                
                                if let arr = responseDict?[API_DATA] as? [[String:AnyObject]] {
                                    
                                    for dict in arr {
                                        let model = MenuModel(dict: dict)
                                        modelArray.append(model)
                                    }
                                    
                                }
                                
                                completionBlock(nil, modelArray)
                                
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
    
    
    //MARK: Get gallery data
    
    func getGalleryDataWith(parameters:[String:Any], showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ dataDict:[String:AnyObject]?, _ modelArray: [GalleryModel]?) -> Void) {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Please wait")
        }
        
        HTTPClient.shared.postDataToServerWith(URLString: Get_Gallery_API, parameters: parameters) { (errorString, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorString != nil {
                    completionBlock(errorString!, nil, nil)
                }else {
                    
                    if responseDict != nil {
                        
                        if let status = responseDict?[API_STATUS] as? String {
                            
                            if status == "true" {
                                
                                var dictToSend:[String:AnyObject] = [:]
                                
                                if let dataArr = responseDict?[API_DATA] as? [[String:AnyObject]] {
                                    
                                    if dataArr.count > 0 {
                                        dictToSend = dataArr[0]
                                    }
                                    
                                }
                                
                                var modelArray:[GalleryModel] = []
                                
                                if let arr = responseDict?["banner_images"] as? [[String:AnyObject]] {
                                    
                                    for dict in arr {
                                        let model = GalleryModel(dict: dict)
                                        modelArray.append(model)
                                    }
                                    
                                }
                                
                                completionBlock(nil, dictToSend, modelArray)
                                
                            }else {
                                
                                if let message = responseDict?[API_ERROR_MESSAGE] as? String {
                                    
                                    completionBlock(message, nil, nil)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    
    //MARK: Get Downloads
    
    func getDownloads(showLoader:Bool, completionBlock: @escaping (_ errorMessage:String?, _ modelArray:[DownloadsModel]?) -> Void) {
        
        if showLoader == true {
            CommonMethods.shared.showLoaderWith(title: "Please Wait")
        }
        
        HTTPClient.shared.getDataFromServerWith(URLString: Get_Downloads_API, parameters: [:]) { (errorMessage, responseDict) in
            
            OperationQueue.main.addOperation({ 
                
                if showLoader == true {
                    CommonMethods.shared.hideLoader()
                }
                
                if errorMessage != nil {
                    completionBlock(errorMessage!, nil)
                }else {
                    
                    if responseDict != nil {
                        
                        if let status = responseDict?[API_STATUS] as? String {
                            
                            if status == "true" {
                                
                                if let arr = responseDict?[API_DATA] as? [[String:AnyObject]] {
                                    
                                    var modelArray:[DownloadsModel] = []
                                    
                                    for dict in arr {
                                        
                                        let model = DownloadsModel(dict: dict)
                                        
                                        modelArray.append(model)
                                    }
                                    
                                    completionBlock(nil, modelArray)
                                    
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
    
}
