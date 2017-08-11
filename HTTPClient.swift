//
//  HTTPClient.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit
import Alamofire


class HTTPClient {
    
    
    //MARK: Singlaton
    
    
    static let shared:HTTPClient = {
        return HTTPClient()
    }()
    
    
    //MARK: Common method for Get
    
    func getDataFromServerWith(URLString:String, parameters:[String:Any], completionBlock: @escaping (_ errorMessage:String?, _ responseDict:[String:AnyObject]?) -> Void) {
        
        Alamofire.request(URLString, method: .get, parameters: parameters).response { (response) in
            
            if response.error != nil {
                completionBlock(response.error?.localizedDescription, nil)
                return
            }
            
            if response.response?.statusCode != 200 {
                completionBlock("Sorry!! Unable to get Data", nil)
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String:AnyObject] {
                    
                    completionBlock(nil, json)
                }
                
            }catch let error {
                
                completionBlock(error.localizedDescription, nil)
            }
            
        }
        
    }
    
    
    //MARK: Post Data to Server
    
    
    func postDataToServerWith(URLString:String, parameters:[String:Any], completionBlock: @escaping (_ errorMessage:String?, _ responseDict:[String:AnyObject]?) -> Void) {
        
        Alamofire.request(URLString, method: .post, parameters: parameters).response { (response) in
            
            if response.error != nil {
                completionBlock(response.error?.localizedDescription, nil)
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String:AnyObject] {
                    completionBlock(nil, json)
                }
                
            }catch let error {
                completionBlock(error.localizedDescription, nil)
            }
            
        }
        
    }
    
}
