//
//  GalleryModel.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 17/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


class GalleryModel: NSObject {
    
    
    // Model Constants
    
    let kImageURLPart = "image"
    let kIsMain = "is_main"
    
    // Model Objects
    
    var imageURLPart = ""
    var isMain = "0"
    
    
    //MARK: Initialisation
    
    
    override init() {
        
        
    }
    
    init(dict:[String:AnyObject]) {
        
        if dict[kImageURLPart] != nil {
            imageURLPart = "\(dict[kImageURLPart]!)"
        }
        
        if dict[kIsMain] != nil {
            isMain = "\(dict[kIsMain]!)"
        }
        
    }
    
}
