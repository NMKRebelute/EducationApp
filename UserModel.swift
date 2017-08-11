//
//  UserModel.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 11/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


class UserModel:NSObject {
    
    // Model Constants
    
    let kID = "id"
    let kFirstName = "first_name"
    let kLastName = "last_name"
    let kUserName = "last_name"
    let kEmail = "email"
    let kMobile = "mobile"
    
    // Model Objects
    
    var userID = ""
    var firstName = ""
    var lastName = ""
    var userName = ""
    var emailId = ""
    var mobileNumber = ""
    
    // Initialisation
    
    override init() {
        
        
        
    }
    
    init(dict:[String:AnyObject]) {
        
        if dict.count > 0 {
            
            if dict[kID] != nil  {
                
                userID = "\(dict[kID]!)"
                
            }
            
            if dict[kFirstName] != nil  {
                
                firstName = "\(dict[kFirstName]!)"
                
            }
            
            if dict[kLastName] != nil  {
                
                lastName = "\(dict[kLastName]!)"
                
            }
            
            if dict[kUserName] != nil  {
                
                userName = "\(dict[kUserName]!)"
                
            }
            
            if dict[kEmail] != nil  {
                
                emailId = "\(dict[kEmail]!)"
                
            }
            
            if dict[kMobile] != nil  {
                
                mobileNumber = "\(dict[kMobile]!)"
                
            }
            
        }
        
    }
    
}
