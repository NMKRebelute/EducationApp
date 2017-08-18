//
//  SocialUser.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 14/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class SocialUserModel: NSObject {
    
    
    // Model Constants
    
    let kEmail = "email"
    let kFirstName = "first_name"
    let kImgURL = "image_url"
    let kLastName = "last_name"
    let kUniqueID = "unique_id"
    
    // Model Objects
    
    var email = ""
    var firstName = ""
    var lastName = ""
    var imgURLString = ""
    var uniqueID = ""
    
    //MARK: Initialisation
    
    
    override init() {
        
        
    }
    
    
    init(dict:[String:AnyObject]) {
        
        if dict[kEmail] != nil {
            email = "\(dict[kEmail]!)"
        }
        
        if dict[kFirstName] != nil {
            firstName = "\(dict[kFirstName]!)"
        }
        
        if dict[kLastName] != nil {
            lastName = "\(dict[kLastName]!)"
        }
        
        if dict[kImgURL] != nil {
            imgURLString = "\(dict[kImgURL]!)"
        }
        
        if dict[kUniqueID] != nil {
            uniqueID = "\(dict[kUniqueID]!)"
        }
        
    }
    
}
